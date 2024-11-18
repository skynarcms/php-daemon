Exmple compose:

```yaml
version: "3.8"
services:
  myapp:
    image: php-daemon:latest
    build:
      context: ./apps/php-daemon
    env_file:
      - ./config/common.env
      - ./config/php.env
    volumes:
      - ./apps/myphpapp:/app
      - ./apps/somelib:/app/vendor/some/lib
```
