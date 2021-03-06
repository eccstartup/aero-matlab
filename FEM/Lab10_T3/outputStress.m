function outputStress(displacements,numberElements,...
    elementNodes,nodeCoordinates,D)

for e=1:numberElements                           
  numNodePerElement = length(elementNodes(e,:));
  numEDOF = 2*numNodePerElement;
  elementDof=zeros(1,numEDOF);
  for i = 1:numNodePerElement
      elementDof(2*i-1)=2*elementNodes(e,i)-1;
      elementDof(2*i)=2*elementNodes(e,i);   
  end
  
  %  B matrix
  x1 = nodeCoordinates(elementNodes(e,1),1);
  y1 = nodeCoordinates(elementNodes(e,1),2);
  x2 = nodeCoordinates(elementNodes(e,2),1);
  y2 = nodeCoordinates(elementNodes(e,2),2);
  x3 = nodeCoordinates(elementNodes(e,3),1);
  y3 = nodeCoordinates(elementNodes(e,3),2);
  A = 1/2*det([1 x1 y1; 1 x2 y2; 1 x3 y3]);
  B = 1/(2*A).*[y2-y3 0 y3-y1 0 y1-y2 0;
                        0 x3-x2 0 x1-x3 0 x2-x1;
                        x3-x2 y2-y3 x1-x3 y3-y1 x2-x1 y1-y2];
    
  stress=D*B*displacements(elementDof);
  fprintf('\nStress in element %u\n',e)
  fprintf('Sigma_xx : %0.6f\n',stress(1))
  fprintf('Sigma_yy : %0.6f\n',stress(2))
  fprintf('Sigma_xy : %0.6f\n',stress(3))
end    