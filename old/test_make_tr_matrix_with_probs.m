num_of_instances=5;
noterange=10;
velmean=80;
velrange=10;
durs=[0.5 1];
ldurs=length(durs);
prob=10;
clc
clear str1
display('[')
for ini=1:num_of_instances
    
    str1=[num2str(randi(noterange)+60) ',' num2str(randi(velrange)+velmean) ',' num2str(durs(randi(ldurs))) ];
    str2=[];
    for ini2=1:num_of_instances
        str2=[str2 '[' num2str(ini2) ',' num2str(prob) ']' ];
        
        if ini2<num_of_instances
            str2=[str2 ','];
        end
    end
    
    str1=[str1 ',' '[' str2 ']'];
    
    str1=['[' str1 ']'];
    if ini<num_of_instances
        str1=[str1 ','];
    end
    display([str1 ''])
end

display(']')