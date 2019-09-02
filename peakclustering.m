function[clustcent,data2cluster]=peakclustering(xx,percent);
N=size(xx,1)*size(xx,1);
col_max=size(xx,1);
dist= squareform(pdist(xx, 'euclidean'));
position=round(N*percent/100);
tt=dist(:);
dtt=reshape(dist,[],1);
sort_dist=sort(dtt);
radius=sort_dist(position);
% empirical method to select epsilon

for i=1:col_max
    density(i)=0.0;
    temp_density(i)=0.0;
end

for i=1:(col_max-1)
    for j=(i+1):col_max
        density(i)=density(i)+exp(-0.5*(dist(i,j)/radius)*(dist(i,j)/radius));

        density(j)=density(j)+exp(-0.5*(dist(i,j)/radius)*(dist(i,j)/radius));
    end
end

dist_max=max(max(dist));
[sort_density,sort_index]=sort(density,'descend');
d_dist(sort_index(1))=-1.0;
d_dist_index(sort_index(1))=0;
for i=2:col_max
    d_dist(sort_index(i))=dist_max;
    for j=1:(i-1)
        if(dist(sort_index(i),sort_index(j))<d_dist(sort_index(i)))
            d_dist(sort_index(i))=dist(sort_index(i),sort_index(j));
            d_dist_index(sort_index(i))=sort_index(j);
        end
    end
end
d_dist(sort_index(1))=max(d_dist(:));

% %plot the 2D figure
% plot(density(:),d_dist(:),'o','MarkerSize',5,'MarkerFaceColor','k','MarkerEdgeColor','k');
% title('Decision Graph','FontSize',15.0)
% xlabel('p_i')
% ylabel('d_i')
% [density(:),d_dist(:)]

for i=1:col_max
    clust_label(i)=-1;
end
clust_num=0;

[select_dist,dist_index]=sort(d_dist,'descend');

clust_num=Parzen_fit(d_dist,density);
% Using statistic method to identify cluster centroids
if clust_num==0
    clust_num=1;
end
for i=1:clust_num
    clust_label(dist_index(i))=i;
    i_clust_label(i)=dist_index(i);
end


[select_dist,dist_index]=sort(d_dist,'descend');
dist_var=0.0;
max_numb=0.0;



for i=1:col_max
    if(clust_label(sort_index(i))==-1)
        clust_label(sort_index(i))=clust_label(d_dist_index(sort_index(i)));
    end
    for i=1:clust_num
        clustcent(i)=i_clust_label(i);
    end
    data2cluster=clust_label;
end
        
    




















