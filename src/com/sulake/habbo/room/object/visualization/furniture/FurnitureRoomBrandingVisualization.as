package com.sulake.habbo.room.object.visualization.furniture
{
    import com.sulake.room.object.IRoomObject;
    import com.sulake.room.object.IRoomObjectModel;
    import com.sulake.room.object.visualization.utils.IGraphicAsset;
    import flash.display.BitmapData;
    import flash.geom.Matrix;
    import com.sulake.room.object.visualization.IRoomObjectSprite;

    public class FurnitureRoomBrandingVisualization extends FurnitureVisualization 
    {

        private static const BRANDED_IMAGE_SPRITE_TAG:String = "branded_image";
        private static const OBJECT_STATE_DEFAULT:int = 0;
        private static const OBJECT_STATE_FLIPH:int = 1;
        private static const _SafeStr_3363:int = 2;
        private static const _SafeStr_3364:int = 3;

        protected var _SafeStr_1716:String;
        protected var _SafeStr_3365:Boolean = false;
        protected var _SafeStr_3360:int;
        protected var _SafeStr_3361:int;
        protected var _SafeStr_3362:int;
        private var _dynamicAssetName:String;


        override public function dispose():void
        {
            if (((_dynamicAssetName) && (assetCollection)))
            {
                assetCollection.disposeAsset(_dynamicAssetName);
                _dynamicAssetName = null;
            };
            super.dispose();
            _SafeStr_1716 = null;
        }

        override protected function updateObject(_arg_1:Number, _arg_2:Number):Boolean
        {
            if (super.updateObject(_arg_1, _arg_2))
            {
                if (_SafeStr_3365)
                {
                    checkAndCreateImageForCurrentState(_arg_1);
                };
                return (true);
            };
            return (false);
        }

        override protected function updateModel(_arg_1:Number):Boolean
        {
            var _local_2:IRoomObject;
            var _local_3:IRoomObjectModel;
            var _local_4:Boolean = super.updateModel(_arg_1);
            if (_local_4)
            {
                _local_2 = object;
                if (_local_2 != null)
                {
                    _local_3 = _local_2.getModel();
                    if (_local_3 != null)
                    {
                        _SafeStr_3360 = _local_3.getNumber("furniture_branding_offset_x");
                        _SafeStr_3361 = _local_3.getNumber("furniture_branding_offset_y");
                        _SafeStr_3362 = _local_3.getNumber("furniture_branding_offset_z");
                    };
                };
            };
            if (!_SafeStr_3365)
            {
                _SafeStr_3365 = checkIfImageReady();
                if (_SafeStr_3365)
                {
                    checkAndCreateImageForCurrentState(_arg_1);
                    return (true);
                };
            }
            else
            {
                if (checkIfImageChanged())
                {
                    _SafeStr_3365 = false;
                    _SafeStr_1716 = null;
                    return (true);
                };
            };
            return (_local_4);
        }

        protected function checkIfImageChanged():Boolean
        {
            var _local_3:IRoomObjectModel;
            var _local_2:String;
            var _local_1:IRoomObject = object;
            if (_local_1 != null)
            {
                _local_3 = _local_1.getModel();
                if (_local_3 != null)
                {
                    _local_2 = _local_3.getString("furniture_branding_image_url");
                    if (((!(_local_2 == null)) && (!(_local_2 == _SafeStr_1716))))
                    {
                        return (true);
                    };
                };
            };
            return (false);
        }

        protected function checkIfImageReady():Boolean
        {
            var _local_4:IRoomObjectModel;
            var _local_3:String;
            var _local_5:Number;
            var _local_6:IGraphicAsset;
            var _local_2:BitmapData;
            var _local_1:IRoomObject = object;
            if (_local_1 != null)
            {
                _local_4 = _local_1.getModel();
                if (_local_4 != null)
                {
                    _local_3 = _local_4.getString("furniture_branding_image_url");
                    if (_local_3 != null)
                    {
                        if (((_SafeStr_1716 == null) || (!(_SafeStr_1716 == _local_3))))
                        {
                            _local_5 = _local_4.getNumber("furniture_branding_image_status");
                            if (_local_5 == 1)
                            {
                                _local_6 = assetCollection.getAsset(_local_3);
                                if (_local_6 != null)
                                {
                                    _local_2 = (_local_6.asset.content as BitmapData);
                                    if (_local_2 != null)
                                    {
                                        imageReady(_local_2, _local_3);
                                        return (true);
                                    };
                                };
                            };
                        };
                    };
                };
            };
            return (false);
        }

        override protected function updateSprites(_arg_1:int, _arg_2:Boolean, _arg_3:int):void
        {
            super.updateSprites(_arg_1, _arg_2, _arg_3);
        }

        protected function imageReady(_arg_1:BitmapData, _arg_2:String):void
        {
            Logger.log(("billboard visualization got image from url = " + _arg_2));
            if (_arg_1 != null)
            {
                _SafeStr_1716 = _arg_2;
            }
            else
            {
                _SafeStr_1716 = null;
            };
        }

        override protected function getSpriteAssetName(_arg_1:int, _arg_2:int):String
        {
            var _local_7:int;
            var _local_4:int = getSize(_arg_1);
            var _local_5:String = type;
            var _local_6:String = "";
            if (_arg_2 < (spriteCount - 1))
            {
                _local_6 = String.fromCharCode(("a".charCodeAt() + _arg_2));
            }
            else
            {
                _local_6 = "sd";
            };
            if (_local_4 == 1)
            {
                _local_5 = (_local_5 + ("_icon_" + _local_6));
            }
            else
            {
                _local_7 = getFrameNumber(_arg_1, _arg_2);
                _local_5 = (_local_5 + ((((((("_" + _local_4) + "_") + _local_6) + "_") + direction) + "_") + _local_7));
            };
            var _local_3:String = getSpriteTag(_arg_1, direction, _arg_2);
            if (((!(_SafeStr_1716 == null)) && (_local_3 == "branded_image")))
            {
                return ((((_SafeStr_1716 + "_") + _local_4) + "_") + object.getState(0));
            };
            return (_local_5);
        }

        private function checkAndCreateImageForCurrentState(_arg_1:int):void
        {
            var _local_2:BitmapData;
            var _local_6:Matrix;
            if (((object == null) || (_SafeStr_1716 == null)))
            {
                return;
            };
            var _local_11:IGraphicAsset = assetCollection.getAsset(_SafeStr_1716);
            if (_local_11 == null)
            {
                return;
            };
            var _local_14:int = object.getState(0);
            var _local_9:int = getSize(_arg_1);
            var _local_12:String = ((((_SafeStr_1716 + "_") + _local_9) + "_") + _local_14);
            var _local_15:IGraphicAsset = assetCollection.getAsset(_local_12);
            if (_local_15 != null)
            {
                return;
            };
            var _local_10:BitmapData = (_local_11.asset.content as BitmapData);
            if (_local_10 == null)
            {
                Logger.log(("could not find bitmap data for image " + _local_12));
                return;
            };
            var _local_4:Boolean = true;
            if (_SafeStr_1716.indexOf("noscale") > -1)
            {
                _local_4 = false;
            };
            if (_SafeStr_1716.indexOf("force32") > -1)
            {
                _local_9 = 32;
            };
            if (((_local_9 == 32) && (_local_4)))
            {
                _local_6 = new Matrix();
                _local_6.scale(0.5, 0.5);
                _local_2 = new BitmapData((_local_10.width / 2), (_local_10.height / 2), true, 0xFFFFFF);
                _local_2.draw(_local_10, _local_6);
            }
            else
            {
                _local_2 = _local_10.clone();
            };
            var _local_7:int;
            var _local_8:int;
            var _local_5:Boolean;
            var _local_13:Boolean;
            switch (_local_14)
            {
                case 0:
                    _local_7 = 0;
                    _local_8 = 0;
                    _local_5 = false;
                    _local_13 = false;
                    break;
                case 1:
                    _local_7 = -(_local_2.width);
                    _local_8 = 0;
                    _local_5 = true;
                    _local_13 = false;
                    break;
                case 2:
                    _local_7 = -(_local_2.width);
                    _local_8 = -(_local_2.height);
                    _local_5 = true;
                    _local_13 = true;
                    break;
                case 3:
                    _local_7 = 0;
                    _local_8 = -(_local_2.height);
                    _local_5 = false;
                    _local_13 = true;
                    break;
                default:
                    Logger.log(("could not handle unknown state " + _local_14));
            };
            if (_dynamicAssetName)
            {
                assetCollection.disposeAsset(_dynamicAssetName);
            };
            _dynamicAssetName = _local_12;
            var _local_3:Boolean = assetCollection.addAsset(_local_12, _local_2, true, _local_7, _local_8, _local_5, _local_13);
            if (!_local_3)
            {
                Logger.log(("could not add asset for image " + _local_12));
            };
        }

        override protected function getLibraryAssetNameForSprite(_arg_1:IGraphicAsset, _arg_2:IRoomObjectSprite):String
        {
            var _local_3:String;
            if (_arg_2.tag != "branded_image")
            {
                return (super.getLibraryAssetNameForSprite(_arg_1, _arg_2));
            };
            if (object)
            {
                _local_3 = object.getModel().getString("furniture_branding_image_url");
            };
            if (((_local_3) && (_local_3.length > 0)))
            {
                return (_local_3);
            };
            return (super.getLibraryAssetNameForSprite(_arg_1, _arg_2));
        }


    }
}

