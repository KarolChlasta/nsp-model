function pmake_synapse(pre,npre,post,npost,weight,delay)
str pre,post
float weight,delay
int syn_num,npre,npost

raddmsg {pre} {post}@{npost} SPIKE
syn_num = {getfield@{npost} {post} nsynapses} - 1
setfield@{npost} {post} synapse[{syn_num}].weight {weight} \
                  synapse[{syn_num}].delay {delay}
    echo {pre} ==>> {post} {weight} {delay}
end
