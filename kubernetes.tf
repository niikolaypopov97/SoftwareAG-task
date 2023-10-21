#Deploying wordpress on container using latest wordpress image and setting environment variables with the details from RDS
resource "kubernetes_deployment" "wordpress_deploy" {
  metadata {
    name = "wordpress"
    labels = {
      App = "wordpress"
    }
  }
  spec {
    replicas = 2
    selector {
      match_labels = {
        App = "wordpress"
      }
    }
    template {
      metadata {
        labels = {
          App = "wordpress"
        }
      }
      spec {
        container {
          image = "wordpress:latest"
          name  = "wordpress"
          env {
            name  = "db_host"
            value = aws_db_instance.my-db.address
          }
          env {
            name  = "db_user"
            value = aws_db_instance.my-db.username
          }
          env {
            name  = "db_password"
            value = aws_db_instance.my-db.password
          }
          env {
            name  = "db_name"
            value = aws_db_instance.my-db.db_name
          }
          #I was unable to run these as the deployment is failing if they are uncommented. If we have a meeting I'll explain what I meant here
          #command = [ "/bin/bash", "-c" ]
          #args = ["-c", "cd /var/www/html && mv wp-config-sample.php wp-config.php && sed 's#database_name_here#$db_name#g' -i wp-config.php && sed 's#username_here#$db_user#g' -i wp-config.php && sed 's#password_here#$db_password#g' -i wp-config.php && sed 's#localhost#$db_host#g' -i wp-config.php"]
          port {
            container_port = 80
          }          
        }
      }
    }
  }
  depends_on = [null_resource.update_eks_conf]
}

resource "kubernetes_service" "wordpress_serv" {
  metadata {
    name = "wordpress"
  }
  spec {
    selector = {
      App = kubernetes_deployment.wordpress_deploy.spec.0.template.0.metadata[0].labels.App
    }
    type = "LoadBalancer"
    port {
      port        = 80
      target_port = 80
    }
  }
  depends_on = [null_resource.update_eks_conf]
}