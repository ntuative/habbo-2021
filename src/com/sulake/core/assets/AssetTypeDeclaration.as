package com.sulake.core.assets
{
    public class AssetTypeDeclaration 
    {

        private var _mimeType:String;
        private var _assetClass:Class;
        private var _loaderClass:Class;
        private var _fileTypes:Array;

        public function AssetTypeDeclaration(_arg_1:String, _arg_2:Class, _arg_3:Class=null, ... _args)
        {
            _mimeType = _arg_1;
            _assetClass = _arg_2;
            _loaderClass = _arg_3;
            if (_args == null)
            {
                _fileTypes = [];
            }
            else
            {
                _fileTypes = _args;
            };
        }

        public function get mimeType():String
        {
            return (_mimeType);
        }

        public function get assetClass():Class
        {
            return (_assetClass);
        }

        public function get loaderClass():Class
        {
            return (_loaderClass);
        }

        public function get fileTypes():Array
        {
            return (_fileTypes);
        }


    }
}