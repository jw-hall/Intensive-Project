function dx=INT(~,pop1,P)
%pop1'=pop1(b1 popE - mu1 pop1 - pop2(conflict + mu1 + mu2)) 
create_i=P(1);
conflict_j=P(2);
collapse_i=P(3);
collapse_j=P(4);
pop2=P(5);
popE=P(6);
dx=pop1*(create_i*popE-collapse_i*pop1-pop2*(conflict_j+collapse_i+collapse_j)); 