package com.sulake.core.window.utils
{
    import __AS3__.vec.Vector;

    public class _SafeStr_224 implements IChildEntityArrayReader 
    {

        protected var _SafeStr_875:Vector.<IChildEntity> = new Vector.<IChildEntity>();


        public function get numChildren():int
        {
            return (_SafeStr_875.length);
        }

        public function getChildAt(_arg_1:int):IChildEntity
        {
            return (_SafeStr_875[_arg_1]);
        }

        public function getChildByID(_arg_1:int):IChildEntity
        {
            var _local_2:IChildEntity;
            for each (_local_2 in _SafeStr_875)
            {
                if (_local_2.id == _arg_1)
                {
                    return (_local_2);
                };
            };
            return (null);
        }

        public function getChildByName(_arg_1:String):IChildEntity
        {
            var _local_2:IChildEntity;
            for each (_local_2 in _SafeStr_875)
            {
                if (_local_2.name == _arg_1)
                {
                    return (_local_2);
                };
            };
            return (null);
        }

        public function getChildIndex(_arg_1:IChildEntity):int
        {
            return (_SafeStr_875.indexOf(_arg_1));
        }

        public function groupChildrenWithID(_arg_1:uint, _arg_2:Array):uint
        {
            var _local_4:IChildEntity;
            var _local_3:uint;
            for each (_local_4 in _SafeStr_875)
            {
                if (_local_4.id == _arg_1)
                {
                    _arg_2.push(_local_4);
                    _local_3++;
                };
            };
            return (_local_3);
        }


    }
}

