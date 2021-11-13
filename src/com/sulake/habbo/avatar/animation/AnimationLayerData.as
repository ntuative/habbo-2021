package com.sulake.habbo.avatar.animation
{
    import com.sulake.habbo.avatar.actions.IActiveActionData;
    import com.sulake.core.utils.Map;
    import com.sulake.habbo.avatar.actions.ActiveActionData;
    import com.sulake.habbo.avatar.actions.IActionDefinition;

    public class AnimationLayerData implements IAnimationLayerData 
    {

        public static const _SafeStr_1251:String = "bodypart";
        public static const _SafeStr_1252:String = "fx";

        private var _id:String;
        private var _action:IActiveActionData;
        private var _animationFrame:int;
        private var _dx:int;
        private var _dy:int;
        private var _dz:int;
        private var _directionOffset:int;
        private var _type:String;
        private var _base:String;
        private var _items:Map = new Map();

        public function AnimationLayerData(_arg_1:XML, _arg_2:String, _arg_3:IActionDefinition)
        {
            _id = String(_arg_1.@id);
            _animationFrame = parseInt(_arg_1.@frame);
            _dx = parseInt(_arg_1.@dx);
            _dy = parseInt(_arg_1.@dy);
            _dz = parseInt(_arg_1.@dz);
            _directionOffset = parseInt(_arg_1.@dd);
            _type = _arg_2;
            _base = String(_arg_1.@base);
            for each (var _local_5:XML in _arg_1.item)
            {
                _items[String(_local_5.@id)] = String(_local_5.@base);
            };
            var _local_4:String = "";
            if (_base != "")
            {
                _local_4 = String(baseAsInt());
            };
            if (_arg_3 != null)
            {
                _action = new ActiveActionData(_arg_3.state, base);
                _action.definition = _arg_3;
            };
        }

        public function get items():Map
        {
            return (_items);
        }

        private function baseAsInt():int
        {
            var _local_1:int;
            var _local_2:int;
            _local_1 = 0;
            while (_local_1 < _base.length)
            {
                _local_2 = (_local_2 + _base.charCodeAt(_local_1));
                _local_1++;
            };
            return (_local_2);
        }

        public function get id():String
        {
            return (_id);
        }

        public function get animationFrame():int
        {
            return (_animationFrame);
        }

        public function get dx():int
        {
            return (_dx);
        }

        public function get dy():int
        {
            return (_dy);
        }

        public function get dz():int
        {
            return (_dz);
        }

        public function get directionOffset():int
        {
            return (_directionOffset);
        }

        public function get type():String
        {
            return (_type);
        }

        public function get base():String
        {
            return (_base);
        }

        public function get action():IActiveActionData
        {
            return (_action);
        }


    }
}

