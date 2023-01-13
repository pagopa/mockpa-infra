resource "kubernetes_cluster_role" "system_cluster_deployer" {
  metadata {
    name = "system-cluster-deployer"
  }

  rule {
    api_groups = [""]
    resources  = ["namespaces", "services", "configmaps", "secrets", "serviceaccounts", ]
    verbs      = ["get", "list", "watch", ]
  }

  rule {
    api_groups = ["rbac.authorization.k8s.io"]
    resources  = ["rolebindings"]
    verbs      = ["get", "list", "watch", ]
  }

  depends_on = [
    module.aks
  ]
}

resource "kubernetes_cluster_role" "cluster_deployer" {
  metadata {
    name = "cluster-deployer"
  }

  rule {
    api_groups = [""]
    resources  = ["services", "configmaps", "secrets"]
    verbs      = ["get", "list", "watch", "create", "update", "patch", "delete"]
  }

  rule {
    api_groups = [""]
    resources  = ["namespaces"]
    verbs      = ["get", "list", "watch", ]
  }

  rule {
    api_groups = ["secrets-store.csi.x-k8s.io"]
    resources  = ["secretproviderclasses"]
    verbs      = ["get", "list", "watch", "create", "update", "patch", "delete"]
  }

  rule {
    api_groups = ["keda.sh"]
    resources  = ["scaledobjects", "triggerauthentications"]
    verbs      = ["get", "list", "watch", "create", "update", "patch", "delete"]
  }

  rule {
    api_groups = ["apps"]
    resources  = ["replicasets"]
    verbs      = ["get", "list", "watch", "create", "update", "patch", "delete"]
  }

  rule {
    api_groups = ["extensions", "apps"]
    resources  = ["deployments"]
    verbs      = ["get", "list", "watch", "create", "update", "patch", "delete"]
  }

  rule {
    api_groups = ["networking.k8s.io"]
    resources  = ["ingresses"]
    verbs      = ["get", "list", "watch", "create", "update", "patch", "delete"]
  }

  rule {
    api_groups = ["rbac.authorization.k8s.io"]
    resources  = ["rolebindings"]
    verbs      = ["get", "list", "watch", ]
  }

  rule {
    api_groups = ["batch"]
    resources  = ["cronjobs"]
    verbs      = ["get", "list", "watch", "create", "update", "patch", "delete"]
  }

  rule {
    api_groups = ["monitoring.coreos.com"]
    resources  = ["servicemonitors", "podmonitors"]
    verbs      = ["get", "list", "watch", "create", "update", "patch", "delete"]
  }

  depends_on = [
    module.aks
  ]
}

resource "kubernetes_cluster_role" "view_extra" {
  metadata {
    name = "view-extra"
  }

  dynamic "rule" {
    for_each = var.env_short == "d" ? [""] : []

    content {
      api_groups = [""]
      resources  = ["pods/attach", "pods/exec", "pods/portforward", "pods/proxy", "secrets", "services/proxy"]
      verbs      = ["get", "list", "watch"]
    }
  }

  dynamic "rule" {
    for_each = var.env_short == "d" ? [""] : []
    content {
      api_groups = [""]
      resources  = ["pods/attach", "pods/exec", "pods/portforward", "pods/proxy"]
      verbs      = ["create", "delete", "deletecollection", "patch", "update"]
    }
  }

  depends_on = [
    module.aks
  ]
}

resource "kubernetes_cluster_role_binding" "view_extra_binding" {
  metadata {
    name = "view-extra-binding"
  }

  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = kubernetes_cluster_role.view_extra.metadata[0].name
  }

  subject {
    kind      = "Group"
    name      = data.azuread_group.adgroup_security.object_id
    namespace = "kube-system"
  }

  subject {
    kind      = "Group"
    name      = data.azuread_group.adgroup_developers.object_id
    namespace = "kube-system"
  }

  subject {
    kind      = "Group"
    name      = data.azuread_group.adgroup_externals.object_id
    namespace = "kube-system"
  }

  subject {
    kind      = "Group"
    name      = data.azuread_group.adgroup_operations.object_id
    namespace = "kube-system"
  }

  subject {
    kind      = "Group"
    name      = data.azuread_group.adgroup_technical_project_managers.object_id
    namespace = "kube-system"
  }

  depends_on = [
    module.aks
  ]
}

resource "kubernetes_cluster_role" "edit_extra" {
  metadata {
    name = "edit-extra"
  }

  rule {
    api_groups = ["rbac.authorization.k8s.io"]
    resources  = ["*"]
    verbs      = ["get", "list"]
  }

  depends_on = [
    module.aks
  ]
}

resource "kubernetes_cluster_role_binding" "edit_extra_binding" {
  metadata {
    name = "edit-extra-binding"
  }

  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = kubernetes_cluster_role.edit_extra.metadata[0].name
  }

  subject {
    kind      = "Group"
    name      = data.azuread_group.adgroup_developers.object_id
    namespace = "kube-system"
  }

  depends_on = [
    module.aks
  ]
}

resource "kubernetes_cluster_role_binding" "edit_binding" {
  metadata {
    name = "edit-binding"
  }

  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = "edit"
  }

  subject {
    kind      = "Group"
    name      = data.azuread_group.adgroup_developers.object_id
    namespace = "kube-system"
  }

  depends_on = [
    module.aks
  ]
}

resource "kubernetes_cluster_role_binding" "view_binding" {
  metadata {
    name = "view-binding"
  }

  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = "view"
  }

  subject {
    kind      = "Group"
    name      = data.azuread_group.adgroup_developers.object_id
    namespace = "kube-system"
  }

  subject {
    kind      = "Group"
    name      = data.azuread_group.adgroup_security.object_id
    namespace = "kube-system"
  }

  subject {
    kind      = "Group"
    name      = data.azuread_group.adgroup_externals.object_id
    namespace = "kube-system"
  }

  subject {
    kind      = "Group"
    name      = data.azuread_group.adgroup_operations.object_id
    namespace = "kube-system"
  }

  subject {
    kind      = "Group"
    name      = data.azuread_group.adgroup_technical_project_managers.object_id
    namespace = "kube-system"
  }

  depends_on = [
    module.aks
  ]
}
