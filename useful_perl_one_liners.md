

### encode string to base64
```
perl -MMIME::Base64 -e 'print encode_base64("string")'
```
> c3RyaW5n

### decode base64 string
```
perl -MMIME::Base64 -le 'print decode_base64("c3RyaW5n")'
```
> string
