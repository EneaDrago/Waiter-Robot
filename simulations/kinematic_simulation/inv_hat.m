function v = inv_hat(V_hat)

    if size(V_hat,1) ~= 3 || size(V_hat,2) ~= 3
        error('La matrice di input deve essere 3x3');
    end
    
     v = [V_hat(3,2);
         V_hat(1,3);
         V_hat(2,1)];
end
