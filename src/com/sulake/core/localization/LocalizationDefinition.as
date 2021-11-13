package com.sulake.core.localization
{
    public class LocalizationDefinition implements ILocalizationDefinition 
    {

        private var _languageCode:String;
        private var _countryCode:String;
        private var _encoding:String;
        private var _name:String;
        private var _url:String;

        public function LocalizationDefinition(_arg_1:String, _arg_2:String, _arg_3:String)
        {
            var _local_4:Array = _arg_1.split("_");
            _languageCode = _local_4[0];
            var _local_5:Array = _local_4[1].split(".");
            _countryCode = _local_5[0];
            _encoding = _local_5[1];
            _name = _arg_2;
            _url = _arg_3;
        }

        public function get id():String
        {
            return ((((_languageCode + "_") + _countryCode) + ".") + _encoding);
        }

        public function get languageCode():String
        {
            return (_languageCode);
        }

        public function get countryCode():String
        {
            return (_countryCode);
        }

        public function get encoding():String
        {
            return (_encoding);
        }

        public function get name():String
        {
            return (_name);
        }

        public function get url():String
        {
            return (_url);
        }


    }
}