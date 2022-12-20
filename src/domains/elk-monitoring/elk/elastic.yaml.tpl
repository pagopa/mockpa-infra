apiVersion: elasticsearch.k8s.elastic.co/v1
kind: Elasticsearch
metadata:
  name: quickstart
spec:
  version: 8.1.2
  nodeSets:
  - name: balancer-nodes
    count: ${num_node_balancer}
    config:
      node.roles: []
      node.store.allow_mmap: false
    podTemplate:
      spec:
        affinity:
          podAntiAffinity:
            requiredDuringSchedulingIgnoredDuringExecution:
              - labelSelector:
                  matchExpressions:
                    - key: elastic
                      operator: In
                      values:
                        - eck
                topologyKey: zone
    volumeClaimTemplates:
    - metadata:
        name: elasticsearch-data
      spec:
        accessModes:
        - ReadWriteOnce
        resources:
          requests:
            storage: ${storage_size_balancer}
        storageClassName: ${storage_class_balancer}
  - name: master-nodes
    count: ${num_node_master}
    config:
      node.roles: ["master"]
      node.store.allow_mmap: false
    podTemplate:
      spec:
        affinity:
          podAntiAffinity:
            requiredDuringSchedulingIgnoredDuringExecution:
              - labelSelector:
                  matchExpressions:
                    - key: elastic
                      operator: In
                      values:
                        - eck
                topologyKey: zone
    volumeClaimTemplates:
    - metadata:
        name: elasticsearch-data
      spec:
        accessModes:
        - ReadWriteOnce
        resources:
          requests:
            storage: ${storage_size_master}
        storageClassName: ${storage_class_master}
  - name: hot-nodes
    count: ${num_node_hot}
    config:
      node.roles: ["ingest","data_content","data_hot"]
      node.store.allow_mmap: false
    podTemplate:
      spec:
        affinity:
          podAntiAffinity:
            requiredDuringSchedulingIgnoredDuringExecution:
              - labelSelector:
                  matchExpressions:
                    - key: elastic
                      operator: In
                      values:
                        - eck
                topologyKey: zone
    volumeClaimTemplates:
    - metadata:
        name: elasticsearch-data
      spec:
        accessModes:
        - ReadWriteOnce
        resources:
          requests:
            storage: ${storage_size_hot}
        storageClassName: ${storage_class_hot}
  - name: data-warm-nodes
    count: ${num_node_warm}
    config:
      node.roles: ["ingest","data_warm"]
      node.store.allow_mmap: false
    podTemplate:
      spec:
        affinity:
          podAntiAffinity:
            requiredDuringSchedulingIgnoredDuringExecution:
              - labelSelector:
                  matchExpressions:
                    - key: elastic
                      operator: In
                      values:
                        - eck
                topologyKey: zone
    volumeClaimTemplates:
    - metadata:
        name: elasticsearch-data
      spec:
        accessModes:
        - ReadWriteOnce
        resources:
          requests:
            storage: ${storage_size_warm}
        storageClassName: ${storage_class_warm}
  - name: data-cold-nodes
    count: ${num_node_cold}
    config:
      node.roles: ["data_cold","transform"]
      node.store.allow_mmap: false
    podTemplate:
      spec:
        affinity:
          podAntiAffinity:
            requiredDuringSchedulingIgnoredDuringExecution:
              - labelSelector:
                  matchExpressions:
                    - key: elastic
                      operator: In
                      values:
                        - eck
                topologyKey: zone
    volumeClaimTemplates:
    - metadata:
        name: elasticsearch-data
      spec:
        accessModes:
        - ReadWriteOnce
        resources:
          requests:
            storage: ${storage_size_cold}
        storageClassName: ${storage_class_cold}