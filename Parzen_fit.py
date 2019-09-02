def Parzen_fit(d_dist,density,n):
        # n 为数据量大小，避免重复计算
        clust_num=0
        dist_index=np.argsort(-(np.array(d_dist)))
        potential=[]
        distance=[]
        potential[:]=density[:]
        distance[:]=d_dist[:]
        a=0.5*np.sqrt(np.sum((potential-np.mean(potential))**2)/(n-1))
        b=0.5*np.sqrt(np.sum((distance-np.mean(distance))**2)/(n-1))
        for i in xrange(n):
                q=0.0;
                e=0.0;
                v=0.0;
                #求势能索引i处的distance期望
                p_value=potential[dist_index[i]]
                for j in xrange(n):
                        if(potential[j]!=p_value):
                                q=q+math.exp(-0.5*((potential[j]-p_value)/a)**2)
                                e=e+distance[j]*math.exp(-0.5*((potential[j]-p_value)/a)**2)
                e=e/q
                #求势能值i处的distance方差
                for j in xrange(n):
                        if(potential[j]!=p_value):
                                v=v+((b**2)*math.exp(-0.5*((potential[j]-p_value)/a)**2)+((distance[j]-e)**2)*math.exp(-0.5*((potential[j]-p_value)/a)**2))
                v=np.sqrt(v/q)
                if (distance[dist_index[i]]>e+2*v):
                        clust_num+=1
                        distance[dist_index[i]]=e
                else:
                        break
        return dist_index,clust_num