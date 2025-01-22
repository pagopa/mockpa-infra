{
  "kubelet-kubernetes/metrics": {
    "enabled": true,
    "streams": {
      "kubernetes.container": {
        "enabled": true,
        "vars": {
          "add_metadata": true,
          "bearer_token_file": "/var/run/secrets/kubernetes.io/serviceaccount/token",
          "hosts": [
            "https://${env.NODE_NAME}:10250"
          ],
          "period": "10s",
          "ssl.verification_mode": "none",
          "add_resource_metadata_config": "",
          "ssl.certificate_authorities": []
        }
      },
      "kubernetes.node": {
        "enabled": true,
        "vars": {
          "add_metadata": true,
          "bearer_token_file": "/var/run/secrets/kubernetes.io/serviceaccount/token",
          "hosts": [
            "https://${env.NODE_NAME}:10250"
          ],
          "period": "10s",
          "ssl.verification_mode": "none",
          "ssl.certificate_authorities": []
        }
      },
      "kubernetes.pod": {
        "enabled": true,
        "vars": {
          "add_metadata": true,
          "bearer_token_file": "/var/run/secrets/kubernetes.io/serviceaccount/token",
          "hosts": [
            "https://${env.NODE_NAME}:10250"
          ],
          "period": "10s",
          "ssl.verification_mode": "none",
          "ssl.certificate_authorities": [],
          "add_resource_metadata_config": ""
        }
      },
      "kubernetes.system": {
        "enabled": true,
        "vars": {
          "add_metadata": true,
          "bearer_token_file": "/var/run/secrets/kubernetes.io/serviceaccount/token",
          "hosts": [
            "https://${env.NODE_NAME}:10250"
          ],
          "period": "10s",
          "ssl.verification_mode": "none",
          "ssl.certificate_authorities": []
        }
      },
      "kubernetes.volume": {
        "enabled": true,
        "vars": {
          "add_metadata": true,
          "bearer_token_file": "/var/run/secrets/kubernetes.io/serviceaccount/token",
          "hosts": [
            "https://${env.NODE_NAME}:10250"
          ],
          "period": "10s",
          "ssl.verification_mode": "none",
          "ssl.certificate_authorities": []
        }
      }
    }
  },
  "kube-state-metrics-kubernetes/metrics": {
    "enabled": true,
    "streams": {
      "kubernetes.state_container": {
        "enabled": true,
        "vars": {
          "add_metadata": true,
          "hosts": [
            "kube-state-metrics:8080"
          ],
          "leaderelection": true,
          "period": "10s",
          "bearer_token_file": "/var/run/secrets/kubernetes.io/serviceaccount/token",
          "ssl.certificate_authorities": [],
          "add_resource_metadata_config": ""
        }
      },
      "kubernetes.state_cronjob": {
        "enabled": true,
        "vars": {
          "add_metadata": true,
          "hosts": [
            "kube-state-metrics:8080"
          ],
          "leaderelection": true,
          "period": "10s",
          "bearer_token_file": "/var/run/secrets/kubernetes.io/serviceaccount/token",
          "ssl.certificate_authorities": []
        }
      },
      "kubernetes.state_daemonset": {
        "enabled": true,
        "vars": {
          "add_metadata": true,
          "hosts": [
            "kube-state-metrics:8080"
          ],
          "leaderelection": true,
          "period": "10s",
          "bearer_token_file": "/var/run/secrets/kubernetes.io/serviceaccount/token",
          "ssl.certificate_authorities": []
        }
      },
      "kubernetes.state_deployment": {
        "enabled": true,
        "vars": {
          "add_metadata": true,
          "hosts": [
            "kube-state-metrics:8080"
          ],
          "leaderelection": true,
          "period": "10s",
          "bearer_token_file": "/var/run/secrets/kubernetes.io/serviceaccount/token",
          "ssl.certificate_authorities": []
        }
      },
      "kubernetes.state_job": {
        "enabled": true,
        "vars": {
          "add_metadata": true,
          "hosts": [
            "kube-state-metrics:8080"
          ],
          "leaderelection": true,
          "period": "10s",
          "bearer_token_file": "/var/run/secrets/kubernetes.io/serviceaccount/token",
          "ssl.certificate_authorities": []
        }
      },
      "kubernetes.state_namespace": {
        "enabled": true,
        "vars": {
          "add_metadata": true,
          "hosts": [
            "kube-state-metrics:8080"
          ],
          "leaderelection": true,
          "period": "10s",
          "bearer_token_file": "/var/run/secrets/kubernetes.io/serviceaccount/token",
          "ssl.certificate_authorities": []
        }
      },
      "kubernetes.state_node": {
        "enabled": true,
        "vars": {
          "add_metadata": true,
          "hosts": [
            "kube-state-metrics:8080"
          ],
          "leaderelection": true,
          "period": "10s",
          "bearer_token_file": "/var/run/secrets/kubernetes.io/serviceaccount/token",
          "ssl.certificate_authorities": []
        }
      },
      "kubernetes.state_persistentvolume": {
        "enabled": true,
        "vars": {
          "add_metadata": true,
          "hosts": [
            "kube-state-metrics:8080"
          ],
          "leaderelection": true,
          "period": "10s",
          "bearer_token_file": "/var/run/secrets/kubernetes.io/serviceaccount/token",
          "ssl.certificate_authorities": []
        }
      },
      "kubernetes.state_persistentvolumeclaim": {
        "enabled": true,
        "vars": {
          "add_metadata": true,
          "hosts": [
            "kube-state-metrics:8080"
          ],
          "leaderelection": true,
          "period": "10s",
          "bearer_token_file": "/var/run/secrets/kubernetes.io/serviceaccount/token",
          "ssl.certificate_authorities": []
        }
      },
      "kubernetes.state_pod": {
        "enabled": true,
        "vars": {
          "add_metadata": true,
          "hosts": [
            "kube-state-metrics:8080"
          ],
          "leaderelection": true,
          "period": "10s",
          "bearer_token_file": "/var/run/secrets/kubernetes.io/serviceaccount/token",
          "ssl.certificate_authorities": [],
          "add_resource_metadata_config": ""
        }
      },
      "kubernetes.state_replicaset": {
        "enabled": true,
        "vars": {
          "add_metadata": true,
          "hosts": [
            "kube-state-metrics:8080"
          ],
          "leaderelection": true,
          "period": "10s",
          "bearer_token_file": "/var/run/secrets/kubernetes.io/serviceaccount/token",
          "ssl.certificate_authorities": []
        }
      },
      "kubernetes.state_resourcequota": {
        "enabled": true,
        "vars": {
          "add_metadata": true,
          "hosts": [
            "kube-state-metrics:8080"
          ],
          "leaderelection": true,
          "period": "10s",
          "bearer_token_file": "/var/run/secrets/kubernetes.io/serviceaccount/token",
          "ssl.certificate_authorities": []
        }
      },
      "kubernetes.state_service": {
        "enabled": true,
        "vars": {
          "add_metadata": true,
          "hosts": [
            "kube-state-metrics:8080"
          ],
          "leaderelection": true,
          "period": "10s",
          "bearer_token_file": "/var/run/secrets/kubernetes.io/serviceaccount/token",
          "ssl.certificate_authorities": []
        }
      },
      "kubernetes.state_statefulset": {
        "enabled": true,
        "vars": {
          "add_metadata": true,
          "hosts": [
            "kube-state-metrics:8080"
          ],
          "leaderelection": true,
          "period": "10s",
          "bearer_token_file": "/var/run/secrets/kubernetes.io/serviceaccount/token",
          "ssl.certificate_authorities": []
        }
      },
      "kubernetes.state_storageclass": {
        "enabled": true,
        "vars": {
          "add_metadata": true,
          "hosts": [
            "kube-state-metrics:8080"
          ],
          "leaderelection": true,
          "period": "10s",
          "bearer_token_file": "/var/run/secrets/kubernetes.io/serviceaccount/token",
          "ssl.certificate_authorities": []
        }
      }
    }
  },
  "kube-apiserver-kubernetes/metrics": {
    "enabled": true,
    "streams": {
      "kubernetes.apiserver": {
        "enabled": true,
        "vars": {
          "bearer_token_file": "/var/run/secrets/kubernetes.io/serviceaccount/token",
          "hosts": [
            "https://${env.KUBERNETES_SERVICE_HOST}:${env.KUBERNETES_SERVICE_PORT}"
          ],
          "leaderelection": true,
          "period": "30s",
          "ssl.certificate_authorities": [
            "/var/run/secrets/kubernetes.io/serviceaccount/ca.crt"
          ]
        }
      }
    }
  },
  "kube-proxy-kubernetes/metrics": {
    "enabled": true,
    "streams": {
      "kubernetes.proxy": {
        "enabled": true,
        "vars": {
          "hosts": [
            "localhost:10249"
          ],
          "period": "10s"
        }
      }
    }
  },
  "kube-scheduler-kubernetes/metrics": {
    "enabled": false,
    "streams": {
      "kubernetes.scheduler": {
        "enabled": false,
        "vars": {
          "bearer_token_file": "/var/run/secrets/kubernetes.io/serviceaccount/token",
          "hosts": [
            "https://0.0.0.0:10259"
          ],
          "period": "10s",
          "ssl.verification_mode": "none",
          "scheduler_label_key": "component",
          "scheduler_label_value": "kube-scheduler"
        }
      }
    }
  },
  "kube-controller-manager-kubernetes/metrics": {
    "enabled": false,
    "streams": {
      "kubernetes.controllermanager": {
        "enabled": false,
        "vars": {
          "bearer_token_file": "/var/run/secrets/kubernetes.io/serviceaccount/token",
          "hosts": [
            "https://0.0.0.0:10257"
          ],
          "period": "10s",
          "ssl.verification_mode": "none",
          "controller_manager_label_key": "component",
          "controller_manager_label_value": "kube-controller-manager"
        }
      }
    }
  },
  "events-kubernetes/metrics": {
    "enabled": true,
    "streams": {
      "kubernetes.event": {
        "enabled": true,
        "vars": {
          "period": "10s",
          "add_metadata": true,
          "skip_older": true,
          "leaderelection": true
        }
      }
    }
  },
  "container-logs-filestream-default": {
    "enabled": true,
    "streams": {
      "kubernetes.container_logs": {
        "enabled": true,
        "vars": {
          "paths": [
            "/var/log/containers/*.log"
          ],
          "excludeFiles": [ ${logs_general_to_exclude_paths} ],
          "symlinks": true,
          "data_stream.dataset": "kubernetes.container_logs",
          "containerParserStream": "all",
          "containerParserFormat": "auto",
          "additionalParsersConfig": "",
          "useFingerprint": true,
          "fingerprintYaml": "enabled: true # This must be set to `true`\noffset: 0\nlength: 1024\n",
          "custom": ""
        }
      }
    }
  },
  %{ for instance_name in dedicated_log_instance_name ~}
  "container-logs-filestream-${instance_name}": {
    "enabled": true,
    "streams": {
      "kubernetes.container_logs": {
        "enabled": true,
        "vars": {
          "paths": [
            "/var/log/containers/${instance_name}-*.log"
          ],
          "symlinks": true,
          "data_stream.dataset": "${env}-${instance_name}",
          "containerParserStream": "all",
          "containerParserFormat": "auto",
          "additionalParsersConfig": "",
          "useFingerprint": true,
          "fingerprintYaml": "enabled: true # This must be set to `true`\noffset: 0\nlength: 1024\n",
          "custom": ""
        }
      }
    }
  }
    %{ if index(dedicated_log_instance_name, instance_name) == length(dedicated_log_instance_name)-1 }
    %{ else}
    ,
    %{ endif }
  %{ endfor ~}
}
