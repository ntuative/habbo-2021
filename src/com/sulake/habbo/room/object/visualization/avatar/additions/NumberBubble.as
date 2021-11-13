package com.sulake.habbo.room.object.visualization.avatar.additions
{
    import com.sulake.habbo.room.object.visualization.avatar.AvatarVisualization;
    import com.sulake.core.assets.BitmapDataAsset;
    import flash.display.BitmapData;
    import com.sulake.room.object.visualization.IRoomObjectSprite;

    public class NumberBubble implements IAvatarAddition 
    {

        private var _id:int = -1;
        private var _SafeStr_1265:AvatarVisualization;
        private var _asset:BitmapDataAsset;
        private var _SafeStr_1266:Number;
        private var _SafeStr_3239:int = 0;
        private var _numberValueFadeDirection:int = 0;
        private var _SafeStr_3240:Boolean = false;
        private var _SafeStr_3241:int = 0;

        public function NumberBubble(_arg_1:int, _arg_2:int, _arg_3:AvatarVisualization)
        {
            _id = _arg_1;
            _SafeStr_3239 = _arg_2;
            _SafeStr_1265 = _arg_3;
        }

        public function get id():int
        {
            return (_id);
        }

        public function get disposed():Boolean
        {
            return (_SafeStr_1265 == null);
        }

        public function dispose():void
        {
            _SafeStr_1265 = null;
            _asset = null;
        }

        public function update(_arg_1:IRoomObjectSprite, _arg_2:Number):void
        {
            var _local_3:int;
            var _local_4:int;
            var _local_5:int;
            if (!_arg_1)
            {
                return;
            };
            _SafeStr_1266 = _arg_2;
            if (_SafeStr_3239 > 0)
            {
                _local_5 = 64;
                if (_arg_2 < 48)
                {
                    _asset = (_SafeStr_1265.getAvatarRendererAsset((("number_" + _SafeStr_3239) + "_small_png")) as BitmapDataAsset);
                    _local_3 = -6;
                    _local_4 = -52;
                    _local_5 = 32;
                }
                else
                {
                    _asset = (_SafeStr_1265.getAvatarRendererAsset((("number_" + _SafeStr_3239) + "_png")) as BitmapDataAsset);
                    _local_3 = -8;
                    _local_4 = -105;
                };
                if (_SafeStr_1265.posture == "sit")
                {
                    _local_4 = int((_local_4 + (_local_5 / 2)));
                }
                else
                {
                    if (_SafeStr_1265.posture == "lay")
                    {
                        _local_4 = (_local_4 + _local_5);
                    };
                };
                if (_asset != null)
                {
                    _arg_1.visible = true;
                    _arg_1.asset = (_asset.content as BitmapData);
                    _arg_1.offsetX = _local_3;
                    _arg_1.offsetY = _local_4;
                    _arg_1.relativeDepth = -0.01;
                    _numberValueFadeDirection = 1;
                    _SafeStr_3240 = true;
                    _SafeStr_3241 = 0;
                    _arg_1.alpha = 0;
                }
                else
                {
                    _arg_1.visible = false;
                };
            }
            else
            {
                if (_arg_1.visible)
                {
                    _numberValueFadeDirection = -1;
                };
            };
        }

        public function animate(_arg_1:IRoomObjectSprite):Boolean
        {
            var _local_2:int;
            if (!_arg_1)
            {
                return (false);
            };
            if (_asset)
            {
                _arg_1.asset = (_asset.content as BitmapData);
            };
            var _local_3:int = _arg_1.alpha;
            var _local_4:Boolean;
            if (_SafeStr_3240)
            {
                _SafeStr_3241++;
                if (_SafeStr_3241 < 10)
                {
                    return (false);
                };
                if (_numberValueFadeDirection < 0)
                {
                    if (_SafeStr_1266 < 48)
                    {
                        _arg_1.offsetY = (_arg_1.offsetY - 2);
                    }
                    else
                    {
                        _arg_1.offsetY = (_arg_1.offsetY - 4);
                    };
                }
                else
                {
                    _local_2 = 4;
                    if (_SafeStr_1266 < 48)
                    {
                        _local_2 = 8;
                    };
                    if ((_SafeStr_3241 % _local_2) == 0)
                    {
                        _arg_1.offsetY = (_arg_1.offsetY - 1);
                        _local_4 = true;
                    };
                };
            };
            if (_numberValueFadeDirection > 0)
            {
                if (_local_3 < 0xFF)
                {
                    _local_3 = (_local_3 + 32);
                };
                if (_local_3 >= 0xFF)
                {
                    _local_3 = 0xFF;
                    _numberValueFadeDirection = 0;
                };
                _arg_1.alpha = _local_3;
                return (true);
            };
            if (_numberValueFadeDirection < 0)
            {
                if (_local_3 >= 0)
                {
                    _local_3 = (_local_3 - 32);
                };
                if (_local_3 <= 0)
                {
                    _numberValueFadeDirection = 0;
                    _SafeStr_3240 = false;
                    _local_3 = 0;
                    _arg_1.visible = false;
                };
                _arg_1.alpha = _local_3;
                return (true);
            };
            return (_local_4);
        }


    }
}

