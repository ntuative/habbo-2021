package com.sulake.room.renderer.cache
{
    import com.sulake.room.renderer.utils.SortableSprite;

        public class RoomObjectSortableSpriteCacheItem 
    {

        private var _sprites:Array = [];
        private var _updateId1:int = -1;
        private var _updateId2:int = -1;
        private var _isEmpty:Boolean = false;


        public function get spriteCount():int
        {
            return (_sprites.length);
        }

        public function get isEmpty():Boolean
        {
            return (_isEmpty);
        }

        public function dispose():void
        {
            setSpriteCount(0);
        }

        public function addSprite(_arg_1:SortableSprite):void
        {
            _sprites.push(_arg_1);
        }

        public function getSprite(_arg_1:int):SortableSprite
        {
            return (_sprites[_arg_1]);
        }

        public function get sprites():Array
        {
            return (_sprites);
        }

        public function needsUpdate(_arg_1:int, _arg_2:int):Boolean
        {
            if (((!(_arg_1 == _updateId1)) || (!(_arg_2 == _updateId2))))
            {
                _updateId1 = _arg_1;
                _updateId2 = _arg_2;
                return (true);
            };
            return (false);
        }

        public function setSpriteCount(_arg_1:int):void
        {
            var _local_3:int;
            var _local_2:SortableSprite;
            if (_arg_1 < _sprites.length)
            {
                _local_3 = _arg_1;
                while (_local_3 < _sprites.length)
                {
                    _local_2 = _sprites[_local_3];
                    if (_local_2)
                    {
                        _local_2.dispose();
                    };
                    _local_3++;
                };
                _sprites.splice(_arg_1, (_sprites.length - _arg_1));
            };
            if (_sprites.length == 0)
            {
                _isEmpty = true;
            }
            else
            {
                _isEmpty = false;
            };
        }


    }
}