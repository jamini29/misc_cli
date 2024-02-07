
## Base64 encode/decode
```
perl -MMIME::Base64 -e 'print encode_base64("string")'
```
> c3RyaW5n
```
perl -MMIME::Base64 -le 'print decode_base64("c3RyaW5n")'
```
> string

## URL-escape/unescape
```
perl -MURI::Escape -le 'print uri_escape("https://aaa.bbb.ccc/?part#ddd")'
```
> https%3A%2F%2Faaa.bbb.ccc%2F%3Fpart%23ddd
```
perl -MURI::Escape -le 'print uri_unescape("https%3A%2F%2Faaa.bbb.ccc%2F%3Fpart%23ddd")'
```
> https://aaa.bbb.ccc/?part#ddd

## HTML-encode/decode
```
perl -MHTML::Entities -le 'print encode_entities("< & >")'
```
> &lt; &amp; &gt;
```
perl -MHTML::Entities -le 'print decode_entities("&lt; &amp; &gt;")'
```
> < & >
