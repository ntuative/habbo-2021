package com.sulake.core.utils
{
    import flash.utils.flash_proxy; 

    use namespace flash.utils.flash_proxy;

    public class _SafeStr_47 extends Map 
    {


        override flash_proxy function setProperty(_arg_1:*, _arg_2:*):void
        {
            if (hasKey(((_arg_1 is QName) ? QName(_arg_1).localName : _arg_1)))
            {
                throw (new Error(((("Trying to overwrite value in SingleWriteMap - key: " + _arg_1) + ", value: ") + _arg_2)));
            };
            super.setProperty(_arg_1, _arg_2);
        }


    }
}

