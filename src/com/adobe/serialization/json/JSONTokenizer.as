package com.adobe.serialization.json
{
    public class JSONTokenizer
    {

        private const controlCharsRegExp:RegExp = /[\x00-\x1F]/;

        private var _SafeStr_669:Boolean;
        private var _SafeStr_670:Object;
        private var jsonString:String;
        private var loc:int;
        private var ch:String;

        public function JSONTokenizer(_arg_1:String, _arg_2:Boolean)
        {
            jsonString = _arg_1;
            this._SafeStr_669 = _arg_2;
            loc = 0;
            nextChar();
        }

        public function getNextToken():JSONToken
        {
            var _local_1:String;
            var _local_3:String;
            var _local_2:String;
            var _local_5:String;
            var _local_4:JSONToken;
            skipIgnored();
            switch (ch)
            {
                case "{":
                    _local_4 = JSONToken.create(1, ch);
                    nextChar();
                    break;
                case "}":
                    _local_4 = JSONToken.create(2, ch);
                    nextChar();
                    break;
                case "[":
                    _local_4 = JSONToken.create(3, ch);
                    nextChar();
                    break;
                case "]":
                    _local_4 = JSONToken.create(4, ch);
                    nextChar();
                    break;
                case ",":
                    _local_4 = JSONToken.create(0, ch);
                    nextChar();
                    break;
                case ":":
                    _local_4 = JSONToken.create(6, ch);
                    nextChar();
                    break;
                case "t":
                    _local_1 = ((("t" + nextChar()) + nextChar()) + nextChar());
                    if (_local_1 == "true")
                    {
                        _local_4 = JSONToken.create(7, true);
                        nextChar();
                    }
                    else
                    {
                        parseError(("Expecting 'true' but found " + _local_1));
                    };
                    break;
                case "f":
                    _local_3 = (((("f" + nextChar()) + nextChar()) + nextChar()) + nextChar());
                    if (_local_3 == "false")
                    {
                        _local_4 = JSONToken.create(8, false);
                        nextChar();
                    }
                    else
                    {
                        parseError(("Expecting 'false' but found " + _local_3));
                    };
                    break;
                case "n":
                    _local_2 = ((("n" + nextChar()) + nextChar()) + nextChar());
                    if (_local_2 == "null")
                    {
                        _local_4 = JSONToken.create(9, null);
                        nextChar();
                    }
                    else
                    {
                        parseError(("Expecting 'null' but found " + _local_2));
                    };
                    break;
                case "N":
                    _local_5 = (("N" + nextChar()) + nextChar());
                    if (_local_5 == "NaN")
                    {
                        _local_4 = JSONToken.create(12, NaN);
                        nextChar();
                    }
                    else
                    {
                        parseError(("Expecting 'NaN' but found " + _local_5));
                    };
                    break;
                case '"':
                    _local_4 = readString();
                    break;
                default:
                    if (((isDigit(ch)) || (ch == "-")))
                    {
                        _local_4 = readNumber();
                    }
                    else
                    {
                        if (ch == "")
                        {
                            _local_4 = null;
                        }
                        else
                        {
                            parseError((("Unexpected " + ch) + " encountered"));
                        };
                    };
            };
            return (_local_4);
        }

        final private function readString():JSONToken
        {
            var _local_2:int;
            var _local_1:int;
            var _local_3:int = loc;
            do
            {
                _local_3 = jsonString.indexOf('"', _local_3);
                if (_local_3 >= 0)
                {
                    _local_2 = 0;
                    _local_1 = (_local_3 - 1);
                    while (jsonString.charAt(_local_1) == "\\")
                    {
                        _local_2++;
                        _local_1--;
                    };
                    if ((_local_2 & 0x01) == 0) break;
                    _local_3++;
                }
                else
                {
                    parseError("Unterminated string literal");
                };
            } while (true);
            var _local_4:JSONToken = JSONToken.create(10, unescapeString(jsonString.substr(loc, (_local_3 - loc))));
            loc = (_local_3 + 1);
            nextChar();
            return (_local_4);
        }

        public function unescapeString(_arg_1:String):String
        {
            var _local_8:String;
            var _local_6:String;
            var _local_4:int;
            var _local_7:int;
            var _local_5:String;
            if (((_SafeStr_669) && (controlCharsRegExp.test(_arg_1))))
            {
                parseError("String contains unescaped control character (0x00-0x1F)");
            };
            var _local_2:String = "";
            var _local_9:int;
            var _local_10:int;
            var _local_3:int = _arg_1.length;
            do
            {
                _local_9 = _arg_1.indexOf("\\", _local_10);
                if (_local_9 >= 0)
                {
                    _local_2 = (_local_2 + _arg_1.substr(_local_10, (_local_9 - _local_10)));
                    _local_10 = (_local_9 + 2);
                    _local_8 = _arg_1.charAt((_local_9 + 1));
                    switch (_local_8)
                    {
                        case '"':
                            _local_2 = (_local_2 + _local_8);
                            break;
                        case "\\":
                            _local_2 = (_local_2 + _local_8);
                            break;
                        case "n":
                            _local_2 = (_local_2 + "\n");
                            break;
                        case "r":
                            _local_2 = (_local_2 + "\r");
                            break;
                        case "t":
                            _local_2 = (_local_2 + "\t");
                            break;
                        case "u":
                            _local_6 = "";
                            _local_4 = (_local_10 + 4);
                            if (_local_4 > _local_3)
                            {
                                parseError("Unexpected end of input.  Expecting 4 hex digits after \\u.");
                            };
                            _local_7 = _local_10;
                            while (_local_7 < _local_4)
                            {
                                _local_5 = _arg_1.charAt(_local_7);
                                if (!isHexDigit(_local_5))
                                {
                                    parseError(("Excepted a hex digit, but found: " + _local_5));
                                };
                                _local_6 = (_local_6 + _local_5);
                                _local_7++;
                            };
                            _local_2 = (_local_2 + String.fromCharCode(parseInt(_local_6, 16)));
                            _local_10 = _local_4;
                            break;
                        case "f":
                            _local_2 = (_local_2 + "\f");
                            break;
                        case "/":
                            _local_2 = (_local_2 + "/");
                            break;
                        case "b":
                            _local_2 = (_local_2 + "\b");
                            break;
                        default:
                            _local_2 = (_local_2 + ("\\" + _local_8));
                    };
                }
                else
                {
                    _local_2 = (_local_2 + _arg_1.substr(_local_10));
                    break;
                };
            } while (_local_10 < _local_3);
            return (_local_2);
        }

        final private function readNumber():JSONToken
        {
            var _local_1:String = "";
            if (ch == "-")
            {
                _local_1 = (_local_1 + "-");
                nextChar();
            };
            if (!isDigit(ch))
            {
                parseError("Expecting a digit");
            };
            if (ch == "0")
            {
                _local_1 = (_local_1 + ch);
                nextChar();
                if (isDigit(ch))
                {
                    parseError("A digit cannot immediately follow 0");
                }
                else
                {
                    if (((!(_SafeStr_669)) && (ch == "x")))
                    {
                        _local_1 = (_local_1 + ch);
                        nextChar();
                        if (isHexDigit(ch))
                        {
                            _local_1 = (_local_1 + ch);
                            nextChar();
                        }
                        else
                        {
                            parseError('Number in hex format require at least one hex digit after "0x"');
                        };
                        while (isHexDigit(ch))
                        {
                            _local_1 = (_local_1 + ch);
                            nextChar();
                        };
                    };
                };
            }
            else
            {
                while (isDigit(ch))
                {
                    _local_1 = (_local_1 + ch);
                    nextChar();
                };
            };
            if (ch == ".")
            {
                _local_1 = (_local_1 + ".");
                nextChar();
                if (!isDigit(ch))
                {
                    parseError("Expecting a digit");
                };
                while (isDigit(ch))
                {
                    _local_1 = (_local_1 + ch);
                    nextChar();
                };
            };
            if (((ch == "e") || (ch == "E")))
            {
                _local_1 = (_local_1 + "e");
                nextChar();
                if (((ch == "+") || (ch == "-")))
                {
                    _local_1 = (_local_1 + ch);
                    nextChar();
                };
                if (!isDigit(ch))
                {
                    parseError("Scientific notation number needs exponent value");
                };
                while (isDigit(ch))
                {
                    _local_1 = (_local_1 + ch);
                    nextChar();
                };
            };
            var _local_2:Number = Number(_local_1);
            if (((isFinite(_local_2)) && (!(isNaN(_local_2)))))
            {
                return (JSONToken.create(11, _local_2));
            };
            parseError((("Number " + _local_2) + " is not valid!"));
            return (null);
        }

        final private function nextChar():String
        {
            return (ch = jsonString.charAt(loc++));
        }

        final private function skipIgnored():void
        {
            var _local_1:int;
            do
            {
                _local_1 = loc;
                skipWhite();
                skipComments();
            } while (_local_1 != loc);
        }

        private function skipComments():void
        {
            if (ch == "/")
            {
                nextChar();
                switch (ch)
                {
                    case "/":
                        do
                        {
                            nextChar();
                        } while (((!(ch == "\n")) && (!(ch == ""))));
                        nextChar();
                        return;
                    case "*":
                        nextChar();
                        while (true)
                        {
                            if (ch == "*")
                            {
                                nextChar();
                                if (ch == "/")
                                {
                                    nextChar();
                                    break;
                                };
                            }
                            else
                            {
                                nextChar();
                            };
                            if (ch == "")
                            {
                                parseError("Multi-line comment not closed");
                            };
                        };
                        return;
                    default:
                        parseError((("Unexpected " + ch) + " encountered (expecting '/' or '*' )"));
                        return;
                };
            };
        }

        final private function skipWhite():void
        {
            while (isWhiteSpace(ch))
            {
                nextChar();
            };
        }

        final private function isWhiteSpace(_arg_1:String):Boolean
        {
            if (((((_arg_1 == " ") || (_arg_1 == "\t")) || (_arg_1 == "\n")) || (_arg_1 == "\r")))
            {
                return (true);
            };
            if (((!(_SafeStr_669)) && (_arg_1.charCodeAt(0) == 160)))
            {
                return (true);
            };
            return (false);
        }

        final private function isDigit(_arg_1:String):Boolean
        {
            return ((_arg_1 >= "0") && (_arg_1 <= "9"));
        }

        final private function isHexDigit(_arg_1:String):Boolean
        {
            return (((isDigit(_arg_1)) || ((_arg_1 >= "A") && (_arg_1 <= "F"))) || ((_arg_1 >= "a") && (_arg_1 <= "f")));
        }

        final public function parseError(_arg_1:String):void
        {
            throw (new JSONParseError(_arg_1, loc, jsonString));
        }


    }
}