use std::env;

/// Struct Config for setup environment variables
#[derive(PartialEq, Debug)]
pub struct Config {
    pub svc_endpoint: String,
    pub svc_port: String,
}

impl Default for Config {
    fn default() -> Self {
        let svc_endpoint: String = "127.0.0.1".to_string();
        let svc_port: String = "8080".to_string();

        Self {
            svc_endpoint,
            svc_port,
        }
    }
}

impl Config {
    pub fn from_envar() -> Self {
        let svc_endpoint: String =
            env::var("SVC_ENDPOINT").expect("Failed to load SVC_ENDPOINT environment variable");
        let svc_port: String =
            env::var("SVC_PORT").expect("Failed to load SVC_PORT environment variable");

        Self {
            svc_endpoint,
            svc_port,
        }
    }
}

#[cfg(test)]
mod test {
    use super::*;

    #[test]
    fn test_default() {
        let svc_endpoint: String = "127.0.0.1".to_string();
        let svc_port: String = "8080".to_string();

        let result = Config::default();

        assert_eq!(result.svc_endpoint, svc_endpoint);
        assert_eq!(result.svc_port, svc_port);
    }

    #[test]
    fn test_from_envar() {
        let svc_endpoint = "127.0.0.1";
        let svc_port = "8080";

        env::set_var("SVC_ENDPOINT", svc_endpoint);
        env::set_var("SVC_PORT", svc_port);

        let result = Config::from_envar();
        assert_eq!(result.svc_endpoint, svc_endpoint);
        assert_eq!(result.svc_port, svc_port);
    }
}
