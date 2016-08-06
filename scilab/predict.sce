// prediction
function res = predict(X)

a = [-2.22428 ,0.41626 ,-0.08565 ,0.59464 ,1.57771];

b = -15.78057 ;

res = a * X' + b;
res = (exp(res)/(1+exp(res)))


if res < 0.5 then
    disp("electro")
    disp(100-100*res)
else 
    disp("classique")
    disp(100*res)
end
endfunction
