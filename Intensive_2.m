create1=1;
collapse1=1;
create2=1;
collapse2=1;
prowess1=1;
prowess2=1;
rho_1=prowess1/(prowess1+prowess2);
rho_2=prowess2/(prowess1+prowess2);

pop_1_0=.1;
pop_2_0=.1;
pop_E_0=.8;

t0=0;
tf=5;

t=linspace(t0,tf,100);

%Numerical solutions
[time,x]=ode45(@INT,t,pop_1_0,[],[create1,rho_2,collapse1,collapse2,pop_2_0,pop_E_0]);
hold on
subplot(311),plot(time,x)
xlabel('time'),ylabel('population'),title('Numerical Solution')

[time,x]=ode45(@INT,t,pop_2_0,[],[create2,rho_1,collapse1,collapse2,pop_1_0,pop_E_0]);
hold on
subplot(312),plot(time,x)
xlabel('time'),ylabel('population'),title('Numerical Solution')

[time,x]=ode45(@INT,t,pop_E_0,[],[0,0,0,0,pop_1_0+pop_2_0,pop_E_0]);
hold on
subplot(313),plot(time,x)
xlabel('time'),ylabel('population'),title('Numerical Solution')

%Stochastic Simulation
max_tries=100;
allocation=zeros(1,100);
% popcounter=zeros(max_tries,size(allocation,2));
for i=1:1:max_tries
    index=1;
    tvec=allocation;
    popvec=allocation;
    Size=0;
    
    tvec(index)=t0;
    popvec(index)=pop_1_0;
    while(tvec(index)<=tf&& popvec(index)>0)

        total_birth_rate=create1*popvec(index);
        total_death_rate=collapse1*popvec(index);
        total_event_rate=total_birth_rate+total_death_rate;
        delta_t=exprnd(1/total_event_rate);

        if(mod(index,100)==0)
            tvec(end)
            tvec=[tvec allocation];
            popvec=[popvec allocation];

        end
        tvec(index+1)=tvec(index)+delta_t;

        %decide on the event
        coin=rand();
        P_birth=total_birth_rate/total_event_rate;
        P_death=total_death_rate/total_event_rate;
        P_fight=.01; 
        if(coin<P_birth)
            popvec(index+1)=popvec(index)+1; %Birth
        elseif(coin<P_birth+P_death)
            popvec(index+1)=popvec(index)-1; %Move
        else
            popvec(index+1)=popvec(index)-1; %Death
        end
            index=index+1; 

    end
    tvec=tvec(1:index-1);
    popvec=popvec(1:index-1);
    
    subplot(414)
    plot(tvec,popvec),hold on
    xlabel('time'),ylabel('X1 Population'),title('Stochastic Simulation of X1')
end