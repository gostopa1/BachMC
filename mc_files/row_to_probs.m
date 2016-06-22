function a=row_to_probs(vec)
vec=squeeze(vec);
a=[];

for j=1:length(vec)
    if vec(j)>0
        for k=1:vec(j)
            a=[a j];
        end
    end
end

if isempty(a)
    a=1:length(vec);
end
    
end