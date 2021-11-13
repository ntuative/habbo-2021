package com.sulake.habbo.room.object.visualization.furniture
{
    import com.sulake.room.object.visualization.RoomObjectSpriteVisualization;
    import com.sulake.habbo.utils.StringBuffer;
    import com.sulake.room.object.visualization.IRoomObjectVisualizationData;
    import com.sulake.room.utils.IRoomGeometry;
    import com.sulake.room.object.visualization.utils.IGraphicAsset;
    import com.sulake.room.object.visualization.IRoomObjectSprite;
    import flash.display.BitmapData;
    import com.sulake.room.object.IRoomObject;
    import com.sulake.room.object.IRoomObjectModel;

    public class FurnitureVisualization extends RoomObjectSpriteVisualization 
    {

        protected static const Z_MULTIPLIER:Number = Math.sqrt(0.5);

        private static var _SafeStr_1262:StringBuffer;
        private static var _SafeStr_3368:Array;

        private var _direction:int;
        private var _SafeStr_3369:Number = NaN;
        private var _selectedColor:int = -1;
        protected var _SafeStr_1257:Number = 1;
        private var _SafeStr_3370:String = null;
        private var _SafeStr_3371:Boolean = false;
        private var _data:FurnitureVisualizationData = null;
        private var _type:String = "";
        private var _SafeStr_3372:Array = [];
        private var _assetNamesFrame:Array = [];
        private var _SafeStr_3373:Number = 0;
        private var _SafeStr_3374:int = -1;
        private var _cacheDirection:int = -1;
        private var _SafeStr_3375:Array = [];
        private var _SafeStr_3376:Array = [];
        private var _spriteColors:Array = [];
        private var _SafeStr_3377:Array = [];
        private var _SafeStr_3378:Array = [];
        private var _SafeStr_3379:Array = [];
        private var _SafeStr_3380:Array = [];
        private var _SafeStr_3381:Array = [];
        protected var _SafeStr_3382:Boolean = true;
        protected var _SafeStr_3288:int = 0;
        protected var _SafeStr_3383:int = -1;
        private var _updatedLayers:int = 0;
        private var _SafeStr_3384:Number = 0;

        public function FurnitureVisualization()
        {
            reset();
            if (!_SafeStr_1262)
            {
                _SafeStr_1262 = new StringBuffer();
                _SafeStr_3368 = [];
                _SafeStr_3368[0] = null;
                _SafeStr_3368[1] = "_";
                _SafeStr_3368[2] = null;
                _SafeStr_3368[3] = "_";
                _SafeStr_3368[4] = null;
                _SafeStr_3368[5] = "_";
                _SafeStr_3368[6] = null;
                _SafeStr_3368[7] = "_";
            };
        }

        protected function set direction(_arg_1:int):void
        {
            _direction = _arg_1;
        }

        protected function get direction():int
        {
            return (_direction);
        }

        protected function get type():String
        {
            return (_type);
        }

        override public function dispose():void
        {
            super.dispose();
            _data = null;
            _SafeStr_3372 = null;
            _assetNamesFrame = null;
            _SafeStr_3375 = null;
            _SafeStr_3376 = null;
            _spriteColors = null;
            _SafeStr_3377 = null;
            _SafeStr_3378 = null;
            _SafeStr_3379 = null;
            _SafeStr_3380 = null;
            _SafeStr_3381 = null;
        }

        override protected function reset():void
        {
            super.reset();
            direction = -1;
            _data = null;
            _SafeStr_3372 = [];
            _assetNamesFrame = [];
            _SafeStr_3375 = [];
            _SafeStr_3376 = [];
            _spriteColors = [];
            _SafeStr_3377 = [];
            _SafeStr_3378 = [];
            _SafeStr_3379 = [];
            _SafeStr_3380 = [];
            _SafeStr_3381 = [];
            this.createSprites(0);
        }

        override public function initialize(_arg_1:IRoomObjectVisualizationData):Boolean
        {
            reset();
            if (((_arg_1 == null) || (!(_arg_1 is FurnitureVisualizationData))))
            {
                return (false);
            };
            _data = (_arg_1 as FurnitureVisualizationData);
            _type = _data.getType();
            return (true);
        }

        override public function update(_arg_1:IRoomGeometry, _arg_2:int, _arg_3:Boolean, _arg_4:Boolean):void
        {
            if (_arg_1 == null)
            {
                return;
            };
            var _local_5:Boolean;
            var _local_6:Number = _arg_1.scale;
            if (updateObject(_local_6, _arg_1.direction.x))
            {
                _local_5 = true;
            };
            if (updateModel(_local_6))
            {
                _local_5 = true;
            };
            var _local_7:int;
            if (_arg_4)
            {
                _updatedLayers = (_updatedLayers | updateAnimation(_local_6));
            }
            else
            {
                _local_7 = (updateAnimation(_local_6) | _updatedLayers);
                _updatedLayers = 0;
            };
            if (((_local_5) || (!(_local_7 == 0))))
            {
                updateSprites(_local_6, _local_5, _local_7);
                _SafeStr_3272 = _local_6;
                increaseUpdateId();
            };
        }

        protected function updateSprites(_arg_1:int, _arg_2:Boolean, _arg_3:int):void
        {
            var _local_5:int;
            var _local_4:int;
            if (_SafeStr_3288 != spriteCount)
            {
                createSprites(_SafeStr_3288);
            };
            if (_arg_2)
            {
                _local_5 = (spriteCount - 1);
                while (_local_5 >= 0)
                {
                    updateSprite(_arg_1, _local_5);
                    _local_5--;
                };
            }
            else
            {
                _local_4 = 0;
                while (_arg_3 > 0)
                {
                    if ((_arg_3 & 0x01))
                    {
                        updateSprite(_arg_1, _local_4);
                    };
                    _local_4++;
                    _arg_3 = (_arg_3 >> 1);
                };
            };
            _SafeStr_3382 = false;
        }

        protected function updateSprite(_arg_1:int, _arg_2:int):void
        {
            var _local_7:IGraphicAsset;
            var _local_3:Number;
            var _local_4:int;
            var _local_5:String = getSpriteAssetName(_arg_1, _arg_2);
            var _local_6:IRoomObjectSprite = getSprite(_arg_2);
            if (((!(_local_6 == null)) && (!(_local_5 == null))))
            {
                _local_7 = getAsset(_local_5, _arg_2);
                if (((!(_local_7 == null)) && (!(_local_7.asset == null))))
                {
                    _local_6.visible = true;
                    _local_6.objectType = _type;
                    _local_6.asset = (_local_7.asset.content as BitmapData);
                    if (_local_7.asset.content == null)
                    {
                        _SafeStr_3270++;
                    };
                    _local_6.flipH = _local_7.flipH;
                    _local_6.flipV = _local_7.flipV;
                    _local_6.direction = _direction;
                    _local_3 = 0;
                    if (_arg_2 != _SafeStr_3383)
                    {
                        _local_6.tag = getSpriteTag(_arg_1, _direction, _arg_2);
                        _local_6.alpha = getSpriteAlpha(_arg_1, _direction, _arg_2);
                        _local_6.color = getSpriteColor(_arg_1, _arg_2, _selectedColor);
                        _local_6.offsetX = (_local_7.offsetX + getSpriteXOffset(_arg_1, _direction, _arg_2));
                        _local_6.offsetY = (_local_7.offsetY + getSpriteYOffset(_arg_1, _direction, _arg_2));
                        _local_6.alphaTolerance = ((getSpriteMouseCapture(_arg_1, _direction, _arg_2)) ? 128 : 0x0100);
                        _local_6.blendMode = getBlendMode(getSpriteInk(_arg_1, _direction, _arg_2));
                        _local_3 = getSpriteZOffset(_arg_1, _direction, _arg_2);
                        _local_3 = (_local_3 - (_arg_2 * 0.001));
                    }
                    else
                    {
                        _local_6.offsetX = _local_7.offsetX;
                        _local_6.offsetY = (_local_7.offsetY + getSpriteYOffset(_arg_1, _direction, _arg_2));
                        _local_4 = 48;
                        _local_4 = (_local_4 * _SafeStr_1257);
                        _local_6.alpha = _local_4;
                        _local_6.alphaTolerance = 0x0100;
                        _local_3 = 1;
                    };
                    _local_3 = (_local_3 * Z_MULTIPLIER);
                    _local_6.relativeDepth = _local_3;
                    _local_6.assetName = _local_7.assetName;
                    _local_6.libraryAssetName = getLibraryAssetNameForSprite(_local_7, _local_6);
                    _local_6.assetPosture = getPostureForAssetFile(_arg_1, _local_7.libraryAssetName);
                    _local_6.clickHandling = _SafeStr_3371;
                }
                else
                {
                    resetSprite(_local_6);
                };
            }
            else
            {
                if (_local_6 != null)
                {
                    resetSprite(_local_6);
                };
            };
        }

        protected function getLibraryAssetNameForSprite(_arg_1:IGraphicAsset, _arg_2:IRoomObjectSprite):String
        {
            return (_arg_1.libraryAssetName);
        }

        private function resetSprite(_arg_1:IRoomObjectSprite):void
        {
            _arg_1.asset = null;
            _arg_1.assetName = "";
            _arg_1.assetPosture = null;
            _arg_1.tag = "";
            _arg_1.flipH = false;
            _arg_1.flipV = false;
            _arg_1.offsetX = 0;
            _arg_1.offsetY = 0;
            _arg_1.relativeDepth = 0;
            _arg_1.clickHandling = false;
        }

        protected function getBlendMode(_arg_1:int):String
        {
            var _local_2:String = "normal";
            switch (_arg_1)
            {
                case 0:
                    break;
                case 1:
                    _local_2 = "add";
                    break;
                case 3:
                    _local_2 = "darken";
                    break;
                case 2:
                    _local_2 = "subtract";
                default:
            };
            return (_local_2);
        }

        protected function updateObject(_arg_1:Number, _arg_2:Number):Boolean
        {
            var _local_4:Number;
            var _local_5:int;
            var _local_3:IRoomObject = object;
            if (_local_3 == null)
            {
                return (false);
            };
            if ((((!(_SafeStr_3271 == _local_3.getUpdateID())) || (!(_arg_1 == _SafeStr_3272))) || (!(_arg_2 == _SafeStr_3369))))
            {
                _local_4 = (_local_3.getDirection().x - (_arg_2 + 135));
                _local_4 = (((_local_4 % 360) + 360) % 360);
                if (_data != null)
                {
                    _local_5 = _data.getDirectionValue(_arg_1, _local_4);
                    direction = _local_5;
                };
                _SafeStr_3271 = _local_3.getUpdateID();
                _SafeStr_3369 = _arg_2;
                _SafeStr_3272 = _arg_1;
                updateAssetAndSpriteCache(_arg_1, _direction);
                return (true);
            };
            return (false);
        }

        protected function updateModel(_arg_1:Number):Boolean
        {
            var _local_4:Number;
            var _local_2:IRoomObject = object;
            if (_local_2 == null)
            {
                return (false);
            };
            var _local_3:IRoomObjectModel = _local_2.getModel();
            if (_local_3 == null)
            {
                return (false);
            };
            if (_SafeStr_3270 != _local_3.getUpdateID())
            {
                _selectedColor = _local_3.getNumber("furniture_color");
                _local_4 = _local_3.getNumber("furniture_alpha_multiplier");
                if (isNaN(_local_4))
                {
                    _local_4 = 1;
                };
                if (_local_4 != _SafeStr_1257)
                {
                    _SafeStr_1257 = _local_4;
                    _SafeStr_3382 = true;
                };
                _SafeStr_3370 = getAdClickUrl(_local_3);
                _SafeStr_3371 = (((!(_SafeStr_3370 == null)) && (!(_SafeStr_3370 == ""))) && (_SafeStr_3370.indexOf("http") == 0));
                _SafeStr_3384 = _local_3.getNumber("furniture_lift_amount");
                _SafeStr_3270 = _local_3.getUpdateID();
                return (true);
            };
            return (false);
        }

        protected function getAdClickUrl(_arg_1:IRoomObjectModel):String
        {
            return (_arg_1.getString("furniture_ad_url"));
        }

        protected function updateAnimation(_arg_1:Number):int
        {
            return (0);
        }

        private function updateAssetAndSpriteCache(_arg_1:Number, _arg_2:int):void
        {
            if (((!(_cacheDirection == _arg_2)) || (!(_SafeStr_3373 == _arg_1))))
            {
                _SafeStr_3372 = [];
                _assetNamesFrame = [];
                _SafeStr_3375 = [];
                _SafeStr_3376 = [];
                _spriteColors = [];
                _SafeStr_3377 = [];
                _SafeStr_3378 = [];
                _SafeStr_3379 = [];
                _SafeStr_3380 = [];
                _SafeStr_3381 = [];
                _cacheDirection = _arg_2;
                _SafeStr_3373 = _arg_1;
                _SafeStr_3374 = getSize(_arg_1);
                updateLayerCount((_data.getLayerCount(_arg_1) + getAdditionalSpriteCount()));
            };
        }

        protected function updateLayerCount(_arg_1:int):void
        {
            _SafeStr_3288 = _arg_1;
            _SafeStr_3383 = (_SafeStr_3288 - getAdditionalSpriteCount());
        }

        protected function getAdditionalSpriteCount():int
        {
            return (1);
        }

        protected function getFrameNumber(_arg_1:int, _arg_2:int):int
        {
            return (0);
        }

        protected function getPostureForAssetFile(_arg_1:int, _arg_2:String):String
        {
            return (null);
        }

        protected function getAsset(_arg_1:String, _arg_2:int=-1):IGraphicAsset
        {
            var _local_3:IGraphicAsset;
            if (assetCollection != null)
            {
                return (assetCollection.getAsset(_arg_1));
            };
            return (null);
        }

        protected function getSpriteAssetName(_arg_1:int, _arg_2:int):String
        {
            if (((_data == null) || (_arg_2 >= FurnitureVisualizationData.LAYER_NAMES.length)))
            {
                return ("");
            };
            var _local_4:String = _SafeStr_3372[_arg_2];
            var _local_3:Boolean = _assetNamesFrame[_arg_2];
            if (((_local_4 == null) || (_local_4.length == 0)))
            {
                _local_4 = getSpriteAssetNameWithoutFrame(_arg_1, _arg_2, true);
                _local_3 = (!(_SafeStr_3374 == 1));
            };
            if (_local_3)
            {
                _local_4 = (_local_4 + getFrameNumber(_arg_1, _arg_2));
            };
            return (_local_4);
        }

        protected function getSpriteAssetNameWithoutFrame(_arg_1:int, _arg_2:int, _arg_3:Boolean):String
        {
            var _local_7:String;
            var _local_4:int = ((_arg_3) ? _SafeStr_3374 : getSize(_arg_1));
            var _local_5:Boolean = (_local_4 == 1);
            if (_arg_2 != _SafeStr_3383)
            {
                _local_7 = FurnitureVisualizationData.LAYER_NAMES[_arg_2];
            }
            else
            {
                _local_7 = "sd";
            };
            if (_local_5)
            {
                return ((_type + "_icon_") + _local_7);
            };
            _SafeStr_3368[0] = _type;
            _SafeStr_3368[2] = _local_4;
            _SafeStr_3368[4] = _local_7;
            _SafeStr_3368[6] = _direction;
            _SafeStr_1262.length = 0;
            _SafeStr_1262.appendStringArray(_SafeStr_3368);
            var _local_6:String = _SafeStr_1262.toString();
            if (_arg_3)
            {
                _SafeStr_3372[_arg_2] = _local_6;
                _assetNamesFrame[_arg_2] = (!(_local_5));
            };
            return (_local_6);
        }

        protected function getSpriteTag(_arg_1:int, _arg_2:int, _arg_3:int):String
        {
            if (_SafeStr_3375[_arg_3] != null)
            {
                return (_SafeStr_3375[_arg_3]);
            };
            if (_data == null)
            {
                return ("");
            };
            var _local_4:String = _data.getTag(_arg_1, _arg_2, _arg_3);
            _SafeStr_3375[_arg_3] = _local_4;
            return (_local_4);
        }

        protected function getSpriteAlpha(_arg_1:int, _arg_2:int, _arg_3:int):int
        {
            if (((!(_SafeStr_3376[_arg_3] == null)) && (!(_SafeStr_3382))))
            {
                return (_SafeStr_3376[_arg_3]);
            };
            if (_data == null)
            {
                return (0xFF);
            };
            var _local_4:int = _data.getAlpha(_arg_1, _arg_2, _arg_3);
            _local_4 = (_local_4 * _SafeStr_1257);
            _SafeStr_3376[_arg_3] = _local_4;
            return (_local_4);
        }

        protected function getSpriteColor(_arg_1:int, _arg_2:int, _arg_3:int):int
        {
            if (_spriteColors[_arg_2] != null)
            {
                return (_spriteColors[_arg_2]);
            };
            if (_data == null)
            {
                return (0xFFFFFF);
            };
            var _local_4:int = _data.getColor(_arg_1, _arg_2, _arg_3);
            _spriteColors[_arg_2] = _local_4;
            return (_local_4);
        }

        protected function getSpriteXOffset(_arg_1:int, _arg_2:int, _arg_3:int):int
        {
            if (_SafeStr_3377[_arg_3] != null)
            {
                return (_SafeStr_3377[_arg_3]);
            };
            if (_data == null)
            {
                return (0);
            };
            var _local_4:int = _data.getXOffset(_arg_1, _arg_2, _arg_3);
            _SafeStr_3377[_arg_3] = _local_4;
            return (_local_4);
        }

        protected function getSpriteYOffset(_arg_1:int, _arg_2:int, _arg_3:int):int
        {
            var _local_4:int;
            if (_arg_3 != _SafeStr_3383)
            {
                if (_SafeStr_3378[_arg_3] != null)
                {
                    return (_SafeStr_3378[_arg_3]);
                };
                if (_data != null)
                {
                    _local_4 = _data.getYOffset(_arg_1, _arg_2, _arg_3);
                    _SafeStr_3378[_arg_3] = _local_4;
                    return (_local_4);
                };
                return (0);
            };
            return (Math.ceil((_SafeStr_3384 * (_arg_1 / 2))));
        }

        protected function getSpriteMouseCapture(_arg_1:int, _arg_2:int, _arg_3:int):Boolean
        {
            if (_SafeStr_3380[_arg_3] != null)
            {
                return (_SafeStr_3380[_arg_3]);
            };
            if (_data == null)
            {
                return (true);
            };
            var _local_4:Boolean = (!(_data.getIgnoreMouse(_arg_1, _arg_2, _arg_3)));
            _SafeStr_3380[_arg_3] = _local_4;
            return (_local_4);
        }

        protected function getSpriteInk(_arg_1:int, _arg_2:int, _arg_3:int):int
        {
            if (_SafeStr_3381[_arg_3] != null)
            {
                return (_SafeStr_3381[_arg_3]);
            };
            if (_data == null)
            {
                return (0);
            };
            var _local_4:int = _data.getInk(_arg_1, _arg_2, _arg_3);
            _SafeStr_3381[_arg_3] = _local_4;
            return (_local_4);
        }

        protected function getSpriteZOffset(_arg_1:int, _arg_2:int, _arg_3:int):Number
        {
            if (_SafeStr_3379[_arg_3] != null)
            {
                return (_SafeStr_3379[_arg_3]);
            };
            if (_data == null)
            {
                return (0);
            };
            var _local_4:Number = _data.getZOffset(_arg_1, _arg_2, _arg_3);
            _SafeStr_3379[_arg_3] = _local_4;
            return (_local_4);
        }

        protected function getSize(_arg_1:int):int
        {
            if (_data != null)
            {
                return (_data.getSize(_arg_1));
            };
            return (_arg_1);
        }

        protected function get data():FurnitureVisualizationData
        {
            return (_data);
        }


    }
}

