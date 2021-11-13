package com.sulake.core.window.iterators
{
    import flash.utils.Proxy;
    import com.sulake.core.window.utils.IIterator;
    import flash.utils.flash_proxy; 

    use namespace flash.utils.flash_proxy;

    public class EmptyIterator extends Proxy implements IIterator 
    {

        public static const INSTANCE:EmptyIterator = new EmptyIterator();


        public function get length():uint
        {
            return (0);
        }

        public function indexOf(_arg_1:*):int
        {
            return (-1);
        }

        override flash_proxy function getProperty(_arg_1:*):*
        {
            return (null);
        }

        override flash_proxy function setProperty(_arg_1:*, _arg_2:*):void
        {
        }

        override flash_proxy function nextNameIndex(_arg_1:int):int
        {
            return (0);
        }

        override flash_proxy function nextValue(_arg_1:int):*
        {
            return (null);
        }


    }
}