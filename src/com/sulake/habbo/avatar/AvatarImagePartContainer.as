package com.sulake.habbo.avatar
{
    import com.sulake.habbo.avatar.structure.figure.IPartColor;
    import com.sulake.habbo.avatar.actions.IActionDefinition;
    import flash.geom.ColorTransform;
    import com.sulake.habbo.avatar.structure.animation.AnimationFrame;

    public class AvatarImagePartContainer 
    {

        private var _bodyPartId:String;
        private var _partType:String;
        private var _flippedPartType:String;
        private var _partId:String;
        private var _color:IPartColor;
        private var _SafeStr_748:Array;
        private var _action:IActionDefinition;
        private var _isColorable:Boolean;
        private var _isBlendable:Boolean;
        private var _blendTransform:ColorTransform;
        private var _paletteMapId:int;

        public function AvatarImagePartContainer(_arg_1:String, _arg_2:String, _arg_3:String, _arg_4:IPartColor, _arg_5:Array, _arg_6:IActionDefinition, _arg_7:Boolean, _arg_8:int, _arg_9:String="", _arg_10:Boolean=false, _arg_11:Number=1)
        {
            _bodyPartId = _arg_1;
            _partType = _arg_2;
            _partId = _arg_3;
            _color = _arg_4;
            _SafeStr_748 = _arg_5;
            _action = _arg_6;
            _isColorable = _arg_7;
            _paletteMapId = _arg_8;
            _flippedPartType = _arg_9;
            _isBlendable = _arg_10;
            _blendTransform = new ColorTransform(1, 1, 1, _arg_11);
            if (_SafeStr_748 == null)
            {
                Logger.log("Null frame list");
            };
            if (_partType == "ey")
            {
                _isColorable = false;
            };
        }

        public function getFrameIndex(_arg_1:int):int
        {
            var _local_3:AnimationFrame;
            if (((!(_SafeStr_748)) || (_SafeStr_748.length == 0)))
            {
                return (0);
            };
            var _local_2:int = (_arg_1 % _SafeStr_748.length);
            if ((_SafeStr_748[_local_2] is AnimationFrame))
            {
                _local_3 = _SafeStr_748[_local_2];
                return (_local_3.number);
            };
            return (_local_2);
        }

        public function getFrameDefinition(_arg_1:int):AnimationFrame
        {
            var _local_2:int = (_arg_1 % _SafeStr_748.length);
            if (((_SafeStr_748) && (_SafeStr_748.length > _local_2)))
            {
                if ((_SafeStr_748[_local_2] is AnimationFrame))
                {
                    return (_SafeStr_748[_local_2] as AnimationFrame);
                };
            };
            return (null);
        }

        public function getCacheableKey(_arg_1:int):String
        {
            var _local_3:AnimationFrame;
            var _local_2:int = (_arg_1 % _SafeStr_748.length);
            if (((_SafeStr_748) && (_SafeStr_748.length > _local_2)))
            {
                if ((_SafeStr_748[_local_2] is AnimationFrame))
                {
                    _local_3 = (_SafeStr_748[_local_2] as AnimationFrame);
                    return ((((partId + ":") + _local_3.assetPartDefinition) + ":") + _local_3.number);
                };
            };
            return ((partId + ":") + _local_2);
        }

        public function get bodyPartId():String
        {
            return (_bodyPartId);
        }

        public function get partType():String
        {
            return (_partType);
        }

        public function get partId():String
        {
            return (_partId);
        }

        public function get color():IPartColor
        {
            return (_color);
        }

        public function get action():IActionDefinition
        {
            return (_action);
        }

        public function set isColorable(_arg_1:Boolean):void
        {
            _isColorable = _arg_1;
        }

        public function get isColorable():Boolean
        {
            return (_isColorable);
        }

        public function get paletteMapId():int
        {
            return (_paletteMapId);
        }

        public function get flippedPartType():String
        {
            return (_flippedPartType);
        }

        public function get isBlendable():Boolean
        {
            return (_isBlendable);
        }

        public function get blendTransform():ColorTransform
        {
            return (_blendTransform);
        }

        public function toString():String
        {
            return ([_bodyPartId, _partType, _partId].join(":"));
        }


    }
}

