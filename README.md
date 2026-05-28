# Items to Yandex Metrika Measurement Protocol

A **Server-side Google Tag Manager** variable template that converts a GA4 ecommerce `items` array into query string parameters compatible with [Yandex Metrika Measurement Protocol](https://yandex.ru/dev/metrika/en/data-import/measurement-upload). URI encoding - optional.

## How it works

The variable takes a GA4 items array and returns a string of query parameters in Yandex Metrika format:

**Input** (GA4 items array):
```json
[
  {
    "item_id": "123",
    "item_name": "Phone",
    "price": 9779,
    "quantity": 1,
    "item_brand": "Google",
    "item_category": "Electronics"
  }
]
```

**Output** (query string):
```
&pr1id=123&pr1nm=Phone&pr1pr=9779&pr1qt=1&pr1br=Google&pr1ca=Electronics
```

## Supported fields

| GA4 field       | Metrika parameter | Example      |
|-----------------|-------------------|--------------|
| item_id         | pr{n}id           | pr1id=123    |
| item_name       | pr{n}nm           | pr1nm=Phone  |
| price           | pr{n}pr           | pr1pr=9779   |
| quantity        | pr{n}qt           | pr1qt=1      |
| item_brand      | pr{n}br           | pr1br=Google |
| item_category   | pr{n}ca           | pr1ca=Electronics |