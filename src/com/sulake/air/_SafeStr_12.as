package com.sulake.air
{
    import com.sulake.habbo.utils.IEncryptedLocalStorage;
    import flash.utils.ByteArray;

    public class _SafeStr_12 implements IEncryptedLocalStorage 
    {


        public static function isSupported():Boolean
        {
            return false;
        }


        public function reset():void
        {
            
        }

        public function storeString(_arg_1:String, _arg_2:String):Boolean
        {
            return false;
        }

        public function restoreString(_arg_1:String):String
        {
            return null;
        }


    }
}

