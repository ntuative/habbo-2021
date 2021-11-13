package com.sulake.core.localization
{
    public class GameDataResources implements IGameDataResources 
    {

        private var _SafeStr_822:String;
        private var _externalTextsHash:String;
        private var _SafeStr_599:String;
        private var _externalVariablesHash:String;
        private var _SafeStr_823:String;
        private var _furniDataHash:String;
        private var _SafeStr_824:String;
        private var _productDataHash:String;


        public static function parse(_arg_1:String):GameDataResources
        {
            var _local_2:Object = JSON.parse(_arg_1);
            var _local_4:GameDataResources = new GameDataResources();
            for each (var _local_3:Object in _local_2.hashes)
            {
                if (_local_3.name == "external_texts")
                {
                    _local_4._SafeStr_822 = _local_3.url;
                    _local_4._externalTextsHash = _local_3.hash;
                }
                else
                {
                    if (_local_3.name == "external_variables")
                    {
                        _local_4._SafeStr_599 = _local_3.url;
                        _local_4._externalVariablesHash = _local_3.hash;
                    }
                    else
                    {
                        if (_local_3.name == "furnidata")
                        {
                            _local_4._SafeStr_823 = _local_3.url;
                            _local_4._furniDataHash = _local_3.hash;
                        }
                        else
                        {
                            if (_local_3.name == "productdata")
                            {
                                _local_4._SafeStr_824 = _local_3.url;
                                _local_4._productDataHash = _local_3.hash;
                            };
                        };
                    };
                };
            };
            return (_local_4);
        }


        public function isValid():Boolean
        {
            return ((((((((_SafeStr_822) && (_externalTextsHash)) && (_SafeStr_599)) && (_externalVariablesHash)) && (_SafeStr_823)) && (_furniDataHash)) && (_SafeStr_824)) && (_productDataHash));
        }

        public function getExternalTextsUrl():String
        {
            return (_SafeStr_822);
        }

        public function getExternalTextsHash():String
        {
            return (_externalTextsHash);
        }

        public function getExternalVariablesUrl():String
        {
            return (_SafeStr_599);
        }

        public function getExternalVariablesHash():String
        {
            return (_externalVariablesHash);
        }

        public function getFurniDataUrl():String
        {
            return (_SafeStr_823);
        }

        public function getFurniDataHash():String
        {
            return (_furniDataHash);
        }

        public function getProductDataUrl():String
        {
            return (_SafeStr_824);
        }

        public function getProductDataHash():String
        {
            return (_productDataHash);
        }


    }
}

