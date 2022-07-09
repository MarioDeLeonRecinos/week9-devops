output "stable_channel_version" {
  value = data.google_container_engine_versions.default.release_channel_default_version["STABLE"]
}