# Geocoder configuration
Geocoder.configure(
  # Geocoding options
  timeout: 10,                # geocoding service timeout (secs) - increased for production
  lookup: :nominatim,         # name of geocoding service (symbol)
  ip_lookup: :ipapi_com,      # name of IP address geocoding service (symbol)
  language: :en,              # ISO-639 language code
  use_https: true,            # use HTTPS for lookup requests? (if supported)
  http_proxy: nil,            # HTTP proxy server (user:pass@host:port)
  https_proxy: nil,           # HTTPS proxy server (user:pass@host:port)
  api_key: nil,               # API key for geocoding service
  cache: nil,                 # cache object (must respond to #[], #[]=, and #del)
  cache_prefix: "geocoder:",  # prefix (string) to use for all cache keys

  # Exceptions that should not be rescued by default
  # (if you want to implement custom error handling);
  # supports SocketError and Timeout::Error
  always_raise: [Geocoder::OverQueryLimitError, Geocoder::RequestDenied, Geocoder::InvalidRequest, Geocoder::InvalidApiKey],

  # Calculation options
  units: :mi,                 # :km for kilometers or :mi for miles
  distances: :linear          # :spherical or :linear
)

# Log Geocoder configuration for debugging
Rails.logger.info "Geocoder configured with timeout: #{Geocoder.config.timeout}s"
Rails.logger.info "Geocoder IP lookup service: #{Geocoder.config.ip_lookup}" 