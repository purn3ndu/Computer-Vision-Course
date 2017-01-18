
%Reading the image
     I =im2double(rgb2gray(imread('doggy.jpg')));
     %I =imread('pacman.pgm');
     
   % Computing edge map
     edgemap = 1 - I/255; 

   % Computing GVF of the edge map f
     
   % Normalizing edgemap to the range [0,1]
    edgemapmin  = min(edgemap(:));
    edgemapmax  = max(edgemap(:));
    edgemap = (edgemap-edgemapmin)/(edgemapmax-edgemapmin);  

    %Creating a boundary condition for the edgemap
    
    %Create a new row and column at the boundary of the image using the
    %pixels present next to the edge of the boundary
    [r,s] = size(edgemap);
    yi = 2:r+1;
    xi = 2:s+1;
    M = zeros(r+2,s+2);
    M(yi,xi) = edgemap;
    M([1 r+2],[1 s+2]) = M([3 r],[3 s]);  % mirroring corners
    M([1 r+2],xi) = M([3 r],xi);          % mirroring left and right boundary
    M(yi,[1 s+2]) = M(yi,[3 s]);          % mirroring top and bottom boundary
    edgemap = M;
    
    
    
    [fx,fy] = gradient(edgemap);     % Calculating the gradient of the edge map
    u = fx; v = fy;            % Initializing GVF to the gradient
    b = fx.*fx + fy.*fy; % Calclating b, i.e. the squared magnitude of the gradient field as in the paper.

    mu = 0.1;
    ITER = 750;
    % Iteratively solve for the GVF u,v
    for i=1:ITER,
      u = u + mu*4*del2(u) - b.*(u-fx);     % Eqn 14a in the paper. Here del2*4 is the discrete laplacian operator.
      v = v + mu*4*del2(v) - b.*(v-fy);     % Eqn 14b
    end
     
     
     mag = sqrt(u.*u + v.*v);
     px = u./(mag+eps);   %Normalizing the gradient vector field matrices(x and y directions) by the magnitude 
     py = v./(mag+eps);   % to get just the unit vector(direction) at each point in the vector field.

  % Display the input image
     image(((1-edgemap)+1)*40); 
     colormap(gray(64));
     
     %Calling imfreehand to let the user draw the active contour around the image.
     title('Please draw the contour around the figure and then double click to accept');
     h = imfreehand();
    n = wait(h);
    m= getPosition(h);
     x = m(:,1);
     y =  m(:,2);
 % contour evolution to snap to the image edge
 ITER = 800;
 kappa = 0.6;

  for i=1:ITER
      
%resampling the curve to form an uniformly distributed set of points for the contour for each iteration. 
%Same as curveflow in Question 1 of assignment.

    cont = x +1i*y;        % Storing the x and y coordinates as a complex number.

    p = 100;   % The contour will be resampled as p number of uniformly separated points.
 
 
    closedcurve = [cont;cont(1)]; % In a discreetized closed curve the first and last point should be same.
    cumul = [0;cumsum(  abs(closedcurve(1:end-1) - closedcurve(2:end))    )];
    resampled = interp1(cumul/cumul(end),closedcurve,(0:p-1)'/p);
  
     x = real(resampled);
     y = imag(resampled);
     
      %Interpolating the active contour in the gradient vector field 
       vfx = interp2(px,x,y);
       vfy = interp2(py,x,y);

     % evolve the contour
       x =   x + kappa*vfx;
       y =   y + kappa*vfy;
       
       %Displaying the evolved contour for this iteration
       hold on
       if (mod(i,10) == 1)
           
            % convert to column data
            x = x(:); y = y(:);

            plot([x;x(1,1)],[y;y(1,1)],'r');
           title(['Contour Evolution in progress,  Evolvetime = ', num2str(i), ' / ', num2str(ITER) ]);
           
       pause(0.1);
       end
  end
  
    % Show the final contour along with the image.
     cla;
     colormap(gray(64)); image(((1-edgemap)+1)*40);
        h = plot([x;x(1,1)],[y;y(1,1)],'r');
        set(h, 'LineWidth', 2);
     title('Resulting contour around the image');
    

    

