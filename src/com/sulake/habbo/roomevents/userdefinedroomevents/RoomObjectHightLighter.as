package com.sulake.habbo.roomevents.userdefinedroomevents
{
    import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
    import flash.display.Shader;
    import flash.utils.ByteArray;
    import flash.filters.ShaderFilter;
    import flash.utils.Dictionary;
    import com.sulake.room.object.IRoomObject;
    import com.sulake.room.object.visualization.IRoomObjectSpriteVisualization;
    import com.sulake.room.object.visualization.IRoomObjectSprite;

    public class RoomObjectHightLighter 
    {

        private var _roomEvents:HabboUserDefinedRoomEvents;
        private var _filterBW:Array;

        public function RoomObjectHightLighter(_arg_1:HabboUserDefinedRoomEvents)
        {
            super();
            var _local_2:Class = null;
            var _local_4:Shader = null;
            var _local_6:ShaderFilter = null;
            _roomEvents = _arg_1;
            _local_2 = HabboUnknownAsset_furnitureFilter_pbj;
            _local_4 = new Shader((new _local_2() as ByteArray));
            _local_6 = new ShaderFilter(_local_4);
            _filterBW = [_local_6];
        }

        public function hide(_arg_1:int):void
        {
            inactivateFurni(getFurni(_arg_1));
        }

        public function hideAll(_arg_1:Dictionary):void
        {
            for (var _local_2:String in _arg_1)
            {
                Logger.log(("Show furni as unselected: " + _local_2));
                inactivateFurni(getFurni(parseInt(_local_2)));
            };
        }

        public function show(_arg_1:int):void
        {
            activateFurni(getFurni(_arg_1));
        }

        public function showAll(_arg_1:Dictionary):void
        {
            for (var _local_2:String in _arg_1)
            {
                Logger.log(("Show furni as selected: " + _local_2));
                activateFurni(getFurni(parseInt(_local_2)));
            };
        }

        private function getFurni(_arg_1:int):IRoomObject
        {
            return (_roomEvents.roomEngine.getRoomObject(_roomEvents.roomId, _arg_1, 10));
        }

        private function activateFurni(_arg_1:IRoomObject):void
        {
            var _local_2:IRoomObjectSpriteVisualization;
            var _local_4:int;
            var _local_3:IRoomObjectSprite;
            if (_arg_1)
            {
                _local_2 = (_arg_1.getVisualization() as IRoomObjectSpriteVisualization);
                Logger.log(("Furni visualization: " + _local_2));
                _local_4 = 0;
                while (_local_4 < _local_2.spriteCount)
                {
                    _local_3 = _local_2.getSprite(_local_4);
                    if (_local_3.blendMode != "add")
                    {
                        _local_3.filters = _filterBW;
                    };
                    _local_4++;
                };
            };
        }

        private function inactivateFurni(_arg_1:IRoomObject):void
        {
            var _local_2:IRoomObjectSpriteVisualization;
            var _local_4:int;
            var _local_3:IRoomObjectSprite;
            if (_arg_1)
            {
                _local_2 = (_arg_1.getVisualization() as IRoomObjectSpriteVisualization);
                Logger.log(("Furni visualization: " + _local_2));
                _local_4 = 0;
                while (_local_4 < _local_2.spriteCount)
                {
                    _local_3 = _local_2.getSprite(_local_4);
                    _local_3.filters = [];
                    _local_4++;
                };
            };
        }


    }
}

