___TERMS_OF_SERVICE___

By creating or modifying this file you agree to Google Tag Manager's Community
Template Gallery Developer Terms of Service available at
https://developers.google.com/tag-manager/gallery-tos (or such other URL as
Google may provide), as modified from time to time.


___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "Items to Yandex Metrika Measurement Protocol",
  "description": "Converts GA4 ecommerce items array into query string parameters compatible with Yandex Metrika Measurement Protocol\nhttps://yandex.ru/dev/metrika/en/data-import/measurement-upload",
  "containerContexts": [
    "SERVER"
  ]
}


___TEMPLATE_PARAMETERS___

[
  {
    "type": "TEXT",
    "name": "items",
    "displayName": "items",
    "simpleValueType": true,
    "valueHint": "{{items}}",
    "help": "Ecom products array"
  },
  {
    "type": "CHECKBOX",
    "name": "shouldEncode",
    "checkboxText": "Enable URI encode",
    "simpleValueType": true,
    "help": "Example: \"?pr1nm\u003dphone\u0026phone\" converts to \n\"?pr1nm\u003dphone%26phone\""
  }
]


___SANDBOXED_JS_FOR_SERVER___

const getType = require('getType');
const encodeUriComponent = require('encodeUriComponent');

var items = data.items;

if (getType(items) !== 'array' || items.length === 0) return undefined;

var result = '';

for (var i = 0; i < items.length; i++) {
  var index = i + 1;

  var fields = [
    {key: 'item_id', suffix: 'id'},
    {key: 'item_name', suffix: 'nm'},
    {key: 'price', suffix: 'pr'},
    {key: 'quantity', suffix: 'qt'},
    {key: 'item_brand', suffix: 'br'},
    {key: 'item_category', suffix: 'ca'}
  ];

  for (var j = 0; j < fields.length; j++) {
    var value = items[i][fields[j].key];

    if (value === undefined || value === null || value === '') continue;

    var strValue = '' + value;

    if (data.shouldEncode) {
      strValue = encodeUriComponent(strValue);
    }

    result += '&pr' + index + fields[j].suffix + '=' + strValue;
  }
}

return result;


___TESTS___

scenarios:
- name: Encode
  code: "let mockData = {};\nmockData.shouldEncode = true;\nmockData.items = \n  \
    \      [{item_id: '123',\n        item_name: 'phone&phone',\n        price: 9779,\n\
    \        quantity: 1,\n        item_brand: 'Google',\n        item_category: 'Apparel'}];\n\
    \nconst result = runCode(mockData);\nassertThat(result).contains('phone%26phone');"
- name: No encode
  code: "let mockData = {};\nmockData.shouldEncode = false;\nmockData.items = \n \
    \       [{item_id: '123',\n        item_name: 'phone',\n        price: 9779,\n\
    \        quantity: 1,\n        item_brand: 'Google',\n        item_category: 'Apparel'}];\n\
    \nconst result = runCode(mockData);\nassertThat(result).contains('&pr1id=123&pr1nm=phone&pr1pr=9779&pr1qt=1&pr1br=Google&pr1ca=Apparel');"
- name: Wrong data
  code: |-
    let mockData = {};
    mockData.shouldEncode = false;
    mockData.items = 'fsdf1';

    const result = runCode(mockData);
    assertThat(result).isUndefined();
- name: Missing data
  code: |-
    let mockData = {};
    mockData.shouldEncode = false;
    mockData.items = [
      {
        item_id: '123',
        item_name: 'phone',
        price: 9779,
        quantity: 1
      }
    ];

    const result = runCode(mockData);

    assertThat(result).contains('&pr1id=123');
    assertThat(result).contains('&pr1nm=phone');
    assertThat(result).contains('&pr1pr=9779');
    assertThat(result).contains('&pr1qt=1');
    assertThat(result).doesNotContain('pr1br');
    assertThat(result).doesNotContain('pr1ca');
setup: ''


___NOTES___

Created on 5/28/2026, 11:05:59 PM


