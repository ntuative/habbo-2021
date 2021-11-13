package com.adobe.serialization.json
{
    public class JSONDecoder
    {

        private var _SafeStr_669:Boolean;
        private var value:*;
        private var _SafeStr_668:JSONTokenizer;
        private var token:JSONToken;

        public function JSONDecoder(_arg_1:String, _arg_2:Boolean)
        {
            this._SafeStr_669 = _arg_2;
            _SafeStr_668 = new JSONTokenizer(_arg_1, _arg_2);
            nextToken();
            value = parseValue();
            if (((_arg_2) && (!(nextToken() == null))))
            {
                _SafeStr_668.parseError("Unexpected characters left in input stream");
            };
        }

        public function getValue():*
        {
            return (value);
        }

        final private function nextToken():JSONToken
        {
            return (token = _SafeStr_668.getNextToken());
        }

        final private function nextValidToken():JSONToken
        {
            token = _SafeStr_668.getNextToken();
            checkValidToken();
            return (token);
        }

        final private function checkValidToken():void
        {
            if (token == null)
            {
                _SafeStr_668.parseError("Unexpected end of input");
            };
        }

        final private function parseArray():Array
        {
            var _local_1:Array = [];
            nextValidToken();
            if (token.type == 4)
            {
                return (_local_1);
            };
            if (((!(_SafeStr_669)) && (token.type == 0)))
            {
                nextValidToken();
                if (token.type == 4)
                {
                    return (_local_1);
                };
                _SafeStr_668.parseError(("Leading commas are not supported.  Expecting ']' but found " + token.value));
            };
            while (true)
            {
                _local_1.push(parseValue());
                nextValidToken();
                if (token.type == 4)
                {
                    return (_local_1);
                };
                if (token.type == 0)
                {
                    nextToken();
                    if (!_SafeStr_669)
                    {
                        checkValidToken();
                        if (token.type == 4)
                        {
                            return (_local_1);
                        };
                    };
                }
                else
                {
                    _SafeStr_668.parseError(("Expecting ] or , but found " + token.value));
                };
            };

            return _local_1;
        }

        final private function parseObject():Object
        {
            var _local_1:String;
            var _local_2:Object = {};
            nextValidToken();
            if (token.type == 2)
            {
                return (_local_2);
            };
            if (((!(_SafeStr_669)) && (token.type == 0)))
            {
                nextValidToken();
                if (token.type == 2)
                {
                    return (_local_2);
                };
                _SafeStr_668.parseError(("Leading commas are not supported.  Expecting '}' but found " + token.value));
            };
            while (true)
            {
                if (token.type == 10)
                {
                    _local_1 = String(token.value);
                    nextValidToken();
                    if (token.type == 6)
                    {
                        nextToken();
                        _local_2[_local_1] = parseValue();
                        nextValidToken();
                        if (token.type == 2)
                        {
                            return (_local_2);
                        };
                        if (token.type == 0)
                        {
                            nextToken();
                            if (!_SafeStr_669)
                            {
                                checkValidToken();
                                if (token.type == 2)
                                {
                                    return (_local_2);
                                };
                            };
                        }
                        else
                        {
                            _SafeStr_668.parseError(("Expecting } or , but found " + token.value));
                        };
                    }
                    else
                    {
                        _SafeStr_668.parseError(("Expecting : but found " + token.value));
                    };
                }
                else
                {
                    _SafeStr_668.parseError(("Expecting string but found " + token.value));
                };
            };

            return _local_2;
        }

        final private function parseValue():Object
        {
            checkValidToken();
            switch (token.type)
            {
                case 1:
                    return (parseObject());
                case 3:
                    return (parseArray());
                case 7:
                case 8:
                case 9:
                case 10:
                case 11:
                    return (token.value);
                case 12:
                    if (!_SafeStr_669)
                    {
                        return (token.value);
                    };
                    _SafeStr_668.parseError(("Unexpected " + token.value));
                default:
                    _SafeStr_668.parseError(("Unexpected " + token.value));
                    return (null);
            };
        }


    }
}