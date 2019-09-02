function[clust_num]=Parzen_fit(d_dist,density);
clust_num=0;
[select_dist,dist_index]=sort(d_dist,'descend');
[n,m]=size(density');
potential=density;
distance=d_dist;
d=0;p=0;j=1;
for i=1:n
    if(distance(i)~=inf)
        d(j)=distance(i);
        p(j)=potential(i);
        j=j+1;
    end
end
a=0.5*std(p);
b=0.5*std(d);
delta=3;
for i=1:n
    q=0.0;e=0.0;v=0.0;
    if distance(dist_index(i))==inf
        clust_num=clust_num+1;
        distance(dist_index(i))=0;
        i=i+1;
    else
        p_value=potential(dist_index(i));
        for j=1:n
            if((distance(j)~=inf) && (potential(j)~=p_value))
                q=q+exp(-0.5*((potential(j)-p_value)/a)^2);
            end
        end
        for j=1:n
            if((distance(j)~=inf) && (potential(j)~=p_value))
                h=distance(j)*exp(-0.5*((potential(j)-p_value)/a)^2);
                e=e+h;
            end
        end
        e=e/q;
        for j=1:n
            if((distance(j)~=inf) && (potential(j)~=p_value))
                v=v+((b^2)*exp(-0.5*((potential(j)-p_value)/a)^2)+((distance(j)-e)^2)*exp(-0.5*((potential(j)-p_value)/a)^2));
            end
        end
        v=sqrt(v/q);
        if (distance(dist_index(i))>e+delta*v)
           clust_num=clust_num+1;
           distance(dist_index(i))=e;
       else
           break;
         end
    end
end
end
    
    
    
    
    
    
    
    
    
    
    