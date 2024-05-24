use crate::{config::config::Config, handler::router::*};
use actix_web::{middleware, web, App, HttpServer};

pub async fn handler(cfg: &Config) -> std::io::Result<()> {
    env_logger::init_from_env(env_logger::Env::new().default_filter_or("info"));
    let service_endpoint = cfg.svc_endpoint.clone();
    let service_port = cfg.svc_port.clone().parse().unwrap();

    log::info!("Starting HTTP Server at http://localhost:8080");

    HttpServer::new(move || {
        App::new()
            .wrap(middleware::Logger::default())
            .service(web::resource("/").route(web::get().to(index)))
    })
    .bind((service_endpoint, service_port))
    .expect("Failed to start HttpServer")
    .run()
    .await
}
