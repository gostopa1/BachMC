function trmat=mc_model(bb,order)

tr_size=[];
for i=1:(order+1)
    tr_size=[tr_size max(bb)];
end

trmat=zeros(tr_size);

    str1=['sub2ind(size(trmat)'];

for i=order:(length(bb)-1)
    ind=bb((i-order+1):(i+1));

    str=str1;
    for i=1:length(ind)
        str=[str ',ind(' num2str(i) ')' ];
    end
    str=[str ')'];
    index=eval(str);
    
    trmat(index)=trmat(index)+1;
end

end