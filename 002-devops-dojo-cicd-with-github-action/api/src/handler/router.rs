use crate::model::handler::*;
use actix_web::{Responder, Result};
use actix_web_lab::respond::Html;
use askama::Template;

pub async fn index() -> Result<impl Responder> {
    let html = Index.render().expect("Failed to render index.html");
    Ok(Html(html))
}
