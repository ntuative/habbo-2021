package com.sulake.habbo.room.object.visualization.pet
{
    import com.sulake.habbo.room.object.visualization.furniture.AnimatedFurnitureVisualization;
    import com.sulake.habbo.room.object.visualization.data.AnimationStateData;
    import com.sulake.core.assets.BitmapDataAsset;
    import flash.display.BitmapData;
    import com.sulake.room.object.visualization.IRoomObjectVisualizationData;
    import com.sulake.room.utils.IRoomGeometry;
    import com.sulake.room.object.IRoomObject;
    import com.sulake.room.object.IRoomObjectModel;
    import com.sulake.room.object.visualization.IRoomObjectSprite;
    import com.sulake.habbo.room.object.visualization.data.AnimationData;
    import com.sulake.habbo.room.object.visualization.data.AnimationFrame;
    import com.sulake.room.object.visualization.utils.IGraphicAsset;
    import com.sulake.habbo.room.object.visualization.furniture.FurnitureVisualizationData;

    public class AnimatedPetVisualization extends AnimatedFurnitureVisualization
    {

        private static const HEAD_SPRITE_TAG:String = "head";
        private static const SADDLE_SPRITE_TAG:String = "saddle";
        private static const HAIR_SPRITE_TAG:String = "hair";
        private static const ADDITIONAL_SPRITE_COUNT:int = 1;
        private static const EXPERIENCE_BUBBLE_VISIBLE_IN_MS:int = 1000;
        private static const EXPERIENCE_BUBBLE_ASSET_NAME:String = "pet_experience_bubble_png";
        private static const POSTURE_ANIMATION_INDEX:int = 0;
        private static const GESTURE_ANIMATION_INDEX:int = 1;
        private static const _SafeStr_3407:int = 2;

        private var _SafeStr_1912:String = "";
        private var _SafeStr_3256:String = "";
        private var _SafeStr_3253:Boolean = false;
        private var _headDirection:int = 0;
        private var _SafeStr_3408:ExperienceData;
        private var _SafeStr_3409:int = 0;
        private var _SafeStr_3410:int = 0;
        private var _SafeStr_1403:AnimatedPetVisualizationData = null;
        private var _paletteName:String = "";
        private var _SafeStr_3411:int = -1;
        private var _SafeStr_3412:Array = [];
        private var _SafeStr_3413:Array = [];
        private var _SafeStr_3414:Array = [];
        private var _color:int = 0xFFFFFF;
        private var _headOnly:Boolean = false;
        private var _SafeStr_3415:Boolean = false;
        private var _SafeStr_3406:Array = [];
        private var _SafeStr_3416:Boolean = false;
        private var _headSprites:Array = [];
        private var _SafeStr_3417:Array = [];
        private var _SafeStr_3418:Array = [];
        private var _previousAnimationDirection:int = -1;

        public function AnimatedPetVisualization()
        {
            while (_SafeStr_3406.length < 2)
            {
                _SafeStr_3406.push(new AnimationStateData());
            };
        }

        override public function dispose():void
        {
            var _local_2:int;
            var _local_1:AnimationStateData;
            super.dispose();
            if (_SafeStr_3406 != null)
            {
                _local_2 = 0;
                while (_local_2 < _SafeStr_3406.length)
                {
                    _local_1 = (_SafeStr_3406[_local_2] as AnimationStateData);
                    if (_local_1 != null)
                    {
                        _local_1.dispose();
                    };
                    _local_2++;
                };
                _SafeStr_3406 = null;
            };
            if (_SafeStr_3408)
            {
                _SafeStr_3408.dispose();
                _SafeStr_3408 = null;
            };
        }

        override protected function getAnimationId(_arg_1:AnimationStateData):int
        {
            return (_arg_1.animationId);
        }

        override public function initialize(_arg_1:IRoomObjectVisualizationData):Boolean
        {
            var _local_2:BitmapDataAsset;
            if (!(_arg_1 is AnimatedPetVisualizationData))
            {
                return (false);
            };
            _SafeStr_1403 = (_arg_1 as AnimatedPetVisualizationData);
            var _local_3:BitmapData;
            if (_SafeStr_1403.commonAssets != null)
            {
                _local_2 = (_SafeStr_1403.commonAssets.getAssetByName("pet_experience_bubble_png") as BitmapDataAsset);
                if (_local_2 != null)
                {
                    _local_3 = (_local_2.content as BitmapData).clone();
                    _SafeStr_3408 = new ExperienceData(_local_3);
                };
            };
            if (super.initialize(_arg_1))
            {
                return (true);
            };
            return (false);
        }

        override public function update(_arg_1:IRoomGeometry, _arg_2:int, _arg_3:Boolean, _arg_4:Boolean):void
        {
            super.update(_arg_1, _arg_2, _arg_3, _arg_4);
            updateExperienceBubble(_arg_2);
        }

        override protected function updateAnimation(_arg_1:Number):int
        {
            var _local_3:int;
            var _local_2:IRoomObject = object;
            if (_local_2 != null)
            {
                _local_3 = _local_2.getDirection().x;
                if (_local_3 != _previousAnimationDirection)
                {
                    _previousAnimationDirection = _local_3;
                    resetAllAnimationFrames();
                };
            };
            return (super.updateAnimation(_arg_1));
        }

        override protected function updateModel(_arg_1:Number):Boolean
        {
            var _local_5:String;
            var _local_10:String;
            var _local_11:Number;
            var _local_7:int;
            var _local_2:Number;
            var _local_6:int;
            var _local_8:Number;
            var _local_4:Number;
            var _local_16:int;
            var _local_15:Array;
            var _local_12:Array;
            var _local_17:Array;
            var _local_9:int;
            var _local_3:Number;
            var _local_13:IRoomObject = object;
            if (_local_13 == null)
            {
                return (false);
            };
            var _local_14:IRoomObjectModel = _local_13.getModel();
            if (_local_14 == null)
            {
                return (false);
            };
            if (_local_14.getUpdateID() != _SafeStr_3270)
            {
                _local_5 = _local_14.getString("figure_posture");
                _local_10 = _local_14.getString("figure_gesture");
                _local_11 = _local_14.getNumber("figure_posture");
                if (!isNaN(_local_11))
                {
                    _local_7 = _SafeStr_1403.getPostureCount(_SafeStr_3272);
                    if (_local_7 > 0)
                    {
                        _local_5 = _SafeStr_1403.getPostureForAnimation(_SafeStr_3272, (_local_11 % _local_7), true);
                        _local_10 = null;
                    };
                };
                _local_2 = _local_14.getNumber("figure_gesture");
                if (!isNaN(_local_2))
                {
                    _local_6 = _SafeStr_1403.getGestureCount(_SafeStr_3272);
                    if (_local_6 > 0)
                    {
                        _local_10 = _SafeStr_1403.getGestureForAnimation(_SafeStr_3272, (_local_2 % _local_6));
                    };
                };
                validateActions(_local_5, _local_10);
                _local_8 = _local_14.getNumber("furniture_alpha_multiplier");
                if (isNaN(_local_8))
                {
                    _local_8 = 1;
                };
                if (_local_8 != _SafeStr_1257)
                {
                    _SafeStr_1257 = _local_8;
                    _SafeStr_3382 = true;
                };
                _SafeStr_3253 = (_local_14.getNumber("figure_sleep") > 0);
                _local_4 = _local_14.getNumber("head_direction");
                if (((!(isNaN(_local_4))) && (_SafeStr_1403.isAllowedToTurnHead)))
                {
                    _headDirection = _local_4;
                }
                else
                {
                    _headDirection = _local_13.getDirection().x;
                };
                _SafeStr_3409 = _local_14.getNumber("figure_experience_timestamp");
                _SafeStr_3410 = _local_14.getNumber("figure_gained_experience");
                _local_16 = _local_14.getNumber("pet_palette_index");
                if (_local_16 != _SafeStr_3411)
                {
                    _SafeStr_3411 = _local_16;
                    _paletteName = _SafeStr_3411.toString();
                };
                _local_15 = _local_14.getNumberArray("pet_custom_layer_ids");
                _SafeStr_3412 = ((_local_15 != null) ? _local_15 : []);
                _local_12 = _local_14.getNumberArray("pet_custom_part_ids");
                _SafeStr_3413 = ((_local_12 != null) ? _local_12 : []);
                _local_17 = _local_14.getNumberArray("pet_custom_palette_ids");
                _SafeStr_3414 = ((_local_17 != null) ? _local_17 : []);
                _local_9 = _local_14.getNumber("pet_is_riding");
                _SafeStr_3415 = ((!(isNaN(_local_9))) && (_local_9 > 0));
                _local_3 = _local_14.getNumber("pet_color");
                if (((!(isNaN(_local_3))) && (!(_local_3 == _color))))
                {
                    _color = _local_3;
                };
                _headOnly = (_local_14.getNumber("pet_head_only") > 0);
                _SafeStr_3270 = _local_14.getUpdateID();
                return (true);
            };
            return (false);
        }

        private function updateExperienceBubble(_arg_1:int):void
        {
            var _local_2:int;
            var _local_3:IRoomObjectSprite;
            if (_SafeStr_3408 != null)
            {
                _SafeStr_3408.alpha = 0;
                if (_SafeStr_3409 > 0)
                {
                    _local_2 = (_arg_1 - _SafeStr_3409);
                    if (_local_2 < 1000)
                    {
                        _SafeStr_3408.alpha = int((Math.sin(((_local_2 / 1000) * 3.14159265358979)) * 0xFF));
                        _SafeStr_3408.setExperience(_SafeStr_3410);
                    }
                    else
                    {
                        _SafeStr_3409 = 0;
                    };
                    _local_3 = getSprite((spriteCount - 1));
                    if (_local_3 != null)
                    {
                        if (_SafeStr_3408.alpha > 0)
                        {
                            _local_3.asset = _SafeStr_3408.image;
                            _local_3.offsetX = -20;
                            _local_3.offsetY = -80;
                            _local_3.alpha = _SafeStr_3408.alpha;
                            _local_3.visible = true;
                        }
                        else
                        {
                            _local_3.asset = null;
                            _local_3.visible = false;
                        };
                    };
                };
            };
        }

        private function validateActions(_arg_1:String, _arg_2:String):void
        {
            var _local_3:int;
            if (_arg_1 != _SafeStr_1912)
            {
                _SafeStr_1912 = _arg_1;
                _local_3 = _SafeStr_1403.getAnimationForPosture(_SafeStr_3272, _arg_1);
                setAnimationForIndex(0, _local_3);
            };
            if (_SafeStr_1403.getGestureDisabled(_SafeStr_3272, _arg_1))
            {
                _arg_2 = null;
            };
            if (_arg_2 != _SafeStr_3256)
            {
                _SafeStr_3256 = _arg_2;
                _local_3 = _SafeStr_1403.getAnimationForGesture(_SafeStr_3272, _arg_2);
                setAnimationForIndex(1, _local_3);
            };
        }

        override protected function updateLayerCount(_arg_1:int):void
        {
            super.updateLayerCount(_arg_1);
            _headSprites = [];
        }

        override protected function getAdditionalSpriteCount():int
        {
            return (super.getAdditionalSpriteCount() + 1);
        }

        override protected function setAnimation(_arg_1:int):void
        {
        }

        private function getAnimationStateData(_arg_1:int):AnimationStateData
        {
            var _local_2:AnimationStateData;
            if (((_arg_1 >= 0) && (_arg_1 < _SafeStr_3406.length)))
            {
                return (_SafeStr_3406[_arg_1]);
            };
            return (null);
        }

        private function setAnimationForIndex(_arg_1:int, _arg_2:int):void
        {
            var _local_3:AnimationStateData = getAnimationStateData(_arg_1);
            if (_local_3 != null)
            {
                if (setSubAnimation(_local_3, _arg_2))
                {
                    _SafeStr_3416 = false;
                };
            };
        }

        override protected function resetAllAnimationFrames():void
        {
            var _local_2:int;
            var _local_1:AnimationStateData;
            _SafeStr_3416 = false;
            _local_2 = (_SafeStr_3406.length - 1);
            while (_local_2 >= 0)
            {
                _local_1 = _SafeStr_3406[_local_2];
                if (_local_1 != null)
                {
                    _local_1.setLayerCount(animatedLayerCount);
                };
                _local_2--;
            };
        }

        override protected function updateAnimations(_arg_1:Number):int
        {
            var _local_5:int;
            var _local_4:AnimationStateData;
            var _local_6:int;
            if (_SafeStr_3416)
            {
                return (0);
            };
            var _local_3:Boolean = true;
            var _local_2:int;
            _local_5 = 0;
            while (_local_5 < _SafeStr_3406.length)
            {
                _local_4 = _SafeStr_3406[_local_5];
                if (_local_4 != null)
                {
                    if (!_local_4.animationOver)
                    {
                        _local_6 = updateFramesForAnimation(_local_4, _arg_1);
                        _local_2 = (_local_2 | _local_6);
                        if (!_local_4.animationOver)
                        {
                            _local_3 = false;
                        }
                        else
                        {
                            if (((AnimationData.isTransitionFromAnimation(_local_4.animationId)) || (AnimationData.isTransitionToAnimation(_local_4.animationId))))
                            {
                                setAnimationForIndex(_local_5, _local_4.animationAfterTransitionId);
                                _local_3 = false;
                            };
                        };
                    };
                };
                _local_5++;
            };
            _SafeStr_3416 = _local_3;
            return (_local_2);
        }

        override protected function getFrameNumber(_arg_1:int, _arg_2:int):int
        {
            var _local_4:int;
            var _local_3:AnimationStateData;
            var _local_5:AnimationFrame;
            _local_4 = (_SafeStr_3406.length - 1);
            while (_local_4 >= 0)
            {
                _local_3 = _SafeStr_3406[_local_4];
                if (_local_3 != null)
                {
                    _local_5 = _local_3.getFrame(_arg_2);
                    if (_local_5 != null)
                    {
                        return (_local_5.id);
                    };
                };
                _local_4--;
            };
            return (super.getFrameNumber(_arg_1, _arg_2));
        }

        override protected function getPostureForAssetFile(_arg_1:int, _arg_2:String):String
        {
            var _local_5:int;
            var _local_6:String;
            var _local_4:Array = _arg_2.split("_");
            var _local_3:int = _local_4.length;
            _local_5 = 0;
            while (_local_5 < _local_4.length)
            {
                if (((_local_4[_local_5] == "64") || (_local_4[_local_5] == "32")))
                {
                    _local_3 = (_local_5 + 3);
                    break;
                };
                _local_5++;
            };
            var _local_7:String;
            if (_local_3 < _local_4.length)
            {
                _local_6 = _local_4[_local_3];
                _local_6 = _local_6.split("@")[0];
                _local_7 = _SafeStr_1403.getPostureForAnimation(_arg_1, (Number(_local_6) / 100), false);
                if (_local_7 == null)
                {
                    _local_7 = _SafeStr_1403.getGestureForAnimationId(_arg_1, (Number(_local_6) / 100));
                };
            };
            return (_local_7);
        }

        override protected function getSpriteXOffset(_arg_1:int, _arg_2:int, _arg_3:int):int
        {
            var _local_6:int;
            var _local_5:AnimationStateData;
            var _local_7:AnimationFrame;
            var _local_4:int = super.getSpriteXOffset(_arg_1, _arg_2, _arg_3);
            _local_6 = (_SafeStr_3406.length - 1);
            while (_local_6 >= 0)
            {
                _local_5 = _SafeStr_3406[_local_6];
                if (_local_5 != null)
                {
                    _local_7 = _local_5.getFrame(_arg_3);
                    if (_local_7 != null)
                    {
                        _local_4 = (_local_4 + _local_7.x);
                    };
                };
                _local_6--;
            };
            return (_local_4);
        }

        override protected function getSpriteYOffset(_arg_1:int, _arg_2:int, _arg_3:int):int
        {
            var _local_6:int;
            var _local_5:AnimationStateData;
            var _local_7:AnimationFrame;
            var _local_4:int = super.getSpriteYOffset(_arg_1, _arg_2, _arg_3);
            _local_6 = (_SafeStr_3406.length - 1);
            while (_local_6 >= 0)
            {
                _local_5 = _SafeStr_3406[_local_6];
                if (_local_5 != null)
                {
                    _local_7 = _local_5.getFrame(_arg_3);
                    if (_local_7 != null)
                    {
                        _local_4 = (_local_4 + _local_7.y);
                    };
                };
                _local_6--;
            };
            return (_local_4);
        }

        override protected function getAsset(_arg_1:String, _arg_2:int=-1):IGraphicAsset
        {
            var _local_3:int;
            var _local_5:String;
            var _local_6:int;
            var _local_7:int;
            var _local_4:IGraphicAsset;
            if (assetCollection != null)
            {
                _local_3 = _SafeStr_3412.indexOf(_arg_2);
                _local_5 = _paletteName;
                _local_6 = -1;
                _local_7 = -1;
                if (_local_3 > -1)
                {
                    _local_6 = _SafeStr_3413[_local_3];
                    _local_7 = _SafeStr_3414[_local_3];
                    _local_5 = ((_local_7 > -1) ? String(_local_7) : _paletteName);
                };
                if (((!(isNaN(_local_6))) && (_local_6 > -1)))
                {
                    _arg_1 = (_arg_1 + ("_" + _local_6));
                };
                _local_4 = assetCollection.getAssetWithPalette(_arg_1, _local_5);
                return (_local_4);
            };
            return (null);
        }

        override protected function getSpriteZOffset(_arg_1:int, _arg_2:int, _arg_3:int):Number
        {
            if (_SafeStr_1403 == null)
            {
                return (0);
            };
            var _local_4:Number = _SafeStr_1403.getZOffset(_arg_1, getDirection(_arg_1, _arg_3), _arg_3);
            return (_local_4);
        }

        override protected function getSpriteAssetName(_arg_1:int, _arg_2:int):String
        {
            var _local_3:int;
            var _local_5:String;
            if (((_headOnly) && (isNonHeadSprite(_arg_2))))
            {
                return (null);
            };
            if (((_SafeStr_3415) && (isSaddleSprite(_arg_2))))
            {
                return (null);
            };
            var _local_4:int = spriteCount;
            if (_arg_2 < (_local_4 - 1))
            {
                _local_3 = getSize(_arg_1);
                if (_arg_2 < (_local_4 - (1 + 1)))
                {
                    if (_arg_2 >= FurnitureVisualizationData.LAYER_NAMES.length)
                    {
                        return (null);
                    };
                    _local_5 = FurnitureVisualizationData.LAYER_NAMES[_arg_2];
                    if (_local_3 == 1)
                    {
                        return ((type + "_icon_") + _local_5);
                    };
                    return ((((((((type + "_") + _local_3) + "_") + _local_5) + "_") + getDirection(_arg_1, _arg_2)) + "_") + getFrameNumber(_local_3, _arg_2));
                };
                return (((((type + "_") + _local_3) + "_sd_") + getDirection(_arg_1, _arg_2)) + "_0");
            };
            return (null);
        }

        override protected function getSpriteColor(_arg_1:int, _arg_2:int, _arg_3:int):int
        {
            if (_arg_2 < (spriteCount - 1))
            {
                return (_color);
            };
            return (0xFFFFFF);
        }

        private function getDirection(_arg_1:int, _arg_2:int):int
        {
            if (isHeadSprite(_arg_2))
            {
                return (_SafeStr_1403.getDirectionValue(_arg_1, _headDirection));
            };
            return (direction);
        }

        private function isHeadSprite(_arg_1:int):Boolean
        {
            var _local_3:Boolean;
            var _local_2:Boolean;
            if (_headSprites[_arg_1] == null)
            {
                _local_3 = (_SafeStr_1403.getTag(_SafeStr_3272, -1, _arg_1) == "head");
                _local_2 = (_SafeStr_1403.getTag(_SafeStr_3272, -1, _arg_1) == "hair");
                if (((_local_3) || (_local_2)))
                {
                    _headSprites[_arg_1] = true;
                }
                else
                {
                    _headSprites[_arg_1] = false;
                };
            };
            return (_headSprites[_arg_1]);
        }

        private function isNonHeadSprite(_arg_1:int):Boolean
        {
            var _local_2:String;
            if (_SafeStr_3417[_arg_1] == null)
            {
                if (_arg_1 < (spriteCount - (1 + 1)))
                {
                    _local_2 = _SafeStr_1403.getTag(_SafeStr_3272, -1, _arg_1);
                    if (((((!(_local_2 == null)) && (_local_2.length > 0)) && (!(_local_2 == "head"))) && (!(_local_2 == "hair"))))
                    {
                        _SafeStr_3417[_arg_1] = true;
                    }
                    else
                    {
                        _SafeStr_3417[_arg_1] = false;
                    };
                }
                else
                {
                    _SafeStr_3417[_arg_1] = true;
                };
            };
            return (_SafeStr_3417[_arg_1]);
        }

        private function isSaddleSprite(_arg_1:int):Boolean
        {
            if (_SafeStr_3418[_arg_1] == null)
            {
                if (_SafeStr_1403.getTag(_SafeStr_3272, -1, _arg_1) == "saddle")
                {
                    _SafeStr_3418[_arg_1] = true;
                }
                else
                {
                    _SafeStr_3418[_arg_1] = false;
                };
            };
            return (_SafeStr_3418[_arg_1]);
        }


    }
}