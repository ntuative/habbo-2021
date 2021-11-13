package com.sulake.habbo.avatar.common
{
    import com.sulake.habbo.avatar.IAvatarImageListener;
    import flash.display.BitmapData;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.IWindow;
    import com.sulake.habbo.avatar.structure.figure.IFigurePartSet;
    import flash.geom.Rectangle;
    import com.sulake.habbo.avatar.IAvatarRenderManager;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import flash.geom.Point;
    import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
    import com.sulake.habbo.avatar.structure.figure.IFigurePart;
    import com.sulake.core.assets.BitmapDataAsset;
    import com.sulake.habbo.avatar.IAvatarFigureContainer;
    import com.sulake.core.assets.IAsset;
    import flash.geom.ColorTransform;
    import com.sulake.habbo.avatar.structure.figure.IPartColor;
    import flash.geom.Matrix;

    public class AvatarEditorGridPartItem implements IAvatarImageListener 
    {

        private static var _downloadIcon:BitmapData;
        private static var DRAW_ORDER:Array = [];

        private const THUMB_DIRECTIONS:Array = [2, 6, 0, 4, 3, 1];

        private var _SafeStr_1275:IAvatarEditorCategoryModel;
        private var _view:IWindowContainer;
        private var _SafeStr_1277:IWindow;
        private var _partSet:IFigurePartSet;
        private var _colors:Array;
        private var _useColors:Boolean;
        private var _isSelected:Boolean = false;
        private var _SafeStr_1278:BitmapData;
        private var _SafeStr_1279:Rectangle;
        private var _colorLayerCount:int = 0;
        private var _SafeStr_1280:IAvatarRenderManager;
        private var _disposed:Boolean;
        private var _isDisabledForWearing:Boolean;

        {
            DRAW_ORDER.push("li");
            DRAW_ORDER.push("lh");
            DRAW_ORDER.push("ls");
            DRAW_ORDER.push("lc");
            DRAW_ORDER.push("bd");
            DRAW_ORDER.push("sh");
            DRAW_ORDER.push("lg");
            DRAW_ORDER.push("ch");
            DRAW_ORDER.push("ca");
            DRAW_ORDER.push("cc");
            DRAW_ORDER.push("cp");
            DRAW_ORDER.push("wa");
            DRAW_ORDER.push("rh");
            DRAW_ORDER.push("rs");
            DRAW_ORDER.push("rc");
            DRAW_ORDER.push("hd");
            DRAW_ORDER.push("fc");
            DRAW_ORDER.push("ey");
            DRAW_ORDER.push("hr");
            DRAW_ORDER.push("hrb");
            DRAW_ORDER.push("fa");
            DRAW_ORDER.push("ea");
            DRAW_ORDER.push("ha");
            DRAW_ORDER.push("he");
            DRAW_ORDER.push("ri");
        }

        public function AvatarEditorGridPartItem(_arg_1:IWindowContainer, _arg_2:IAvatarEditorCategoryModel, _arg_3:IFigurePartSet, _arg_4:Array, _arg_5:Boolean=true, _arg_6:Boolean=false)
        {
            super();
            var _local_7:IFigurePart = null;
            var _local_8:Array = null;
            _SafeStr_1275 = _arg_2;
            _partSet = _arg_3;
            _view = _arg_1;
            _SafeStr_1277 = _view.findChildByTag("BG_COLOR");
            _colors = _arg_4;
            _useColors = _arg_5;
            _isDisabledForWearing = _arg_6;
            if (_arg_3 == null)
            {
                _SafeStr_1278 = new BitmapData(1, 1, true, 0xFFFFFF);
            };
            if (_arg_3 != null)
            {
                _local_8 = _arg_3.parts;
                for each (_local_7 in _local_8)
                {
                    _colorLayerCount = Math.max(_colorLayerCount, _local_7.colorLayerIndex);
                };
            };
            _SafeStr_1280 = _SafeStr_1275.controller.manager.avatarRenderManager;
            _view.addEventListener("WME_OVER", onMouseOver);
            _view.addEventListener("WME_OUT", onMousetOut);
            updateThumbVisualization();
        }

        private function onMousetOut(_arg_1:WindowMouseEvent):void
        {
            if (!_isSelected)
            {
                _SafeStr_1277.visible = false;
            };
            _SafeStr_1277.blend = 1;
        }

        private function onMouseOver(_arg_1:WindowMouseEvent):void
        {
            if (!_isSelected)
            {
                _SafeStr_1277.visible = true;
                _SafeStr_1277.blend = 0.5;
            };
        }

        public function dispose():void
        {
            if (_disposed)
            {
                return;
            };
            _SafeStr_1275 = null;
            _partSet = null;
            if (_view != null)
            {
                if (!_view.disposed)
                {
                    _view.dispose();
                };
            };
            _view = null;
            if (_SafeStr_1278)
            {
                _SafeStr_1278.dispose();
            };
            _SafeStr_1278 = null;
            _disposed = true;
            _downloadIcon = null;
            _SafeStr_1277 = null;
            _SafeStr_1279 = null;
            _SafeStr_1280 = null;
            _disposed = true;
            _colors = null;
        }

        public function get disposed():Boolean
        {
            return (_disposed);
        }

        public function get view():IWindowContainer
        {
            return (_view);
        }

        public function get isSelected():Boolean
        {
            return (_isSelected);
        }

        public function set isSelected(_arg_1:Boolean):void
        {
            _isSelected = _arg_1;
            updateThumbVisualization();
        }

        public function get id():int
        {
            if (_partSet == null)
            {
                return (-1);
            };
            return (_partSet.id);
        }

        public function get colorLayerCount():int
        {
            return (_colorLayerCount);
        }

        public function update():void
        {
            updateThumbVisualization();
        }

        public function set iconImage(_arg_1:BitmapData):void
        {
            _SafeStr_1278 = _arg_1;
            updateThumbVisualization();
        }

        public function get partSet():IFigurePartSet
        {
            return (_partSet);
        }

        public function set colors(_arg_1:Array):void
        {
            _colors = _arg_1;
            updateThumbVisualization();
        }

        private function updateThumbVisualization():void
        {
            var _local_1:BitmapData;
            var _local_3:BitmapData;
            var _local_4:int;
            var _local_6:int;
            if (((!(_view)) || (_view.disposed)))
            {
                return;
            };
            var _local_5:IBitmapWrapperWindow = (_view.findChildByName("bitmap") as IBitmapWrapperWindow);
            if (_local_5)
            {
                if (((!(_SafeStr_1278 == null)) && (!(_useColors))))
                {
                    _local_1 = _SafeStr_1278;
                }
                else
                {
                    _local_1 = renderThumb();
                    if (!_local_1)
                    {
                        return;
                    };
                };
                _local_3 = ((_local_5.bitmap) ? _local_5.bitmap : new BitmapData(_local_5.width, _local_5.height));
                _local_3.fillRect(_local_3.rect, 0xFFFFFF);
                _local_4 = int(((_local_3.width - _local_1.width) / 2));
                _local_6 = int(((_local_3.height - _local_1.height) / 2));
                _local_3.copyPixels(_local_1, _local_1.rect, new Point(_local_4, _local_6), null, null, true);
                _local_5.bitmap = _local_3;
            };
            var _local_7:IWindow = _view.findChildByTag("CLUB_ICON");
            var _local_2:IStaticBitmapWrapperWindow = (_view.findChildByTag("SELLABLE_ICON") as IStaticBitmapWrapperWindow);
            if (_partSet)
            {
                _local_7.visible = (_partSet.clubLevel > 0);
                _local_2.visible = _partSet.isSellable;
            }
            else
            {
                _local_7.visible = false;
                _local_2.visible = false;
            };
            if (_isDisabledForWearing)
            {
                setAlpha(_local_3, 0.2);
            };
            if (_SafeStr_1277 == null)
            {
                return;
            };
            _SafeStr_1277.visible = _isSelected;
            _SafeStr_1277.blend = 1;
            _view.invalidate();
        }

        private function analyzePartLayers():Boolean
        {
            var _local_4:IFigurePart;
            var _local_6:String;
            var _local_7:BitmapDataAsset;
            var _local_3:BitmapData;
            if (_SafeStr_1275 == null)
            {
                _SafeStr_1279 = null;
                return (false);
            };
            if ((((!(partSet)) || (!(partSet.parts))) || (partSet.parts.length == 0)))
            {
                _SafeStr_1279 = null;
                return (false);
            };
            if (!_SafeStr_1280)
            {
                return (false);
            };
            var _local_2:IAvatarFigureContainer = _SafeStr_1280.createFigureContainer(((partSet.type + "-") + partSet.id));
            if (!_SafeStr_1280.isFigureReady(_local_2))
            {
                _SafeStr_1280.downloadFigure(_local_2, this);
                return (false);
            };
            var _local_8:int;
            var _local_5:Boolean;
            var _local_1:Rectangle = new Rectangle();
            for each (_local_4 in partSet.parts)
            {
                if (_local_5)
                {
                    _local_6 = ((((((("h_std_" + _local_4.type) + "_") + _local_4.id) + "_") + THUMB_DIRECTIONS[_local_8]) + "_") + "0");
                    _local_7 = (_SafeStr_1280.getAssetByName(_local_6) as BitmapDataAsset);
                }
                else
                {
                    _local_8 = 0;
                    while (((!(_local_5)) && (_local_8 < THUMB_DIRECTIONS.length)))
                    {
                        _local_6 = ((((((("h_std_" + _local_4.type) + "_") + _local_4.id) + "_") + THUMB_DIRECTIONS[_local_8]) + "_") + "0");
                        _local_7 = (_SafeStr_1280.getAssetByName(_local_6) as BitmapDataAsset);
                        if (((_local_7) && (_local_7.content)))
                        {
                            _local_5 = true;
                        }
                        else
                        {
                            _local_8++;
                        };
                    };
                };
                if (((_local_7) && (_local_7.content)))
                {
                    _local_3 = (_local_7.content as BitmapData);
                    _local_1 = _local_1.union(new Rectangle((-1 * _local_7.offset.x), (-1 * _local_7.offset.y), _local_7.rectangle.width, _local_7.rectangle.height));
                };
            };
            if (((_local_1) && (_local_1.width > 0)))
            {
                _SafeStr_1279 = _local_1;
                return (true);
            };
            return (false);
        }

        private function renderThumb():BitmapData
        {
            var _local_11:IAsset;
            var _local_4:BitmapData;
            var _local_3:IFigurePart;
            var _local_10:String;
            var _local_12:BitmapDataAsset;
            var _local_1:BitmapData;
            var _local_7:int;
            var _local_8:int;
            var _local_13:ColorTransform;
            var _local_2:IPartColor;
            var _local_6:Rectangle;
            if (partSet == null)
            {
                return (null);
            };
            if (_SafeStr_1275 == null)
            {
                return (null);
            };
            if (_SafeStr_1279 == null)
            {
                if (!analyzePartLayers())
                {
                    if (!_downloadIcon)
                    {
                        _local_11 = _SafeStr_1275.controller.manager.windowManager.assets.getAssetByName("avatar_editor_avatar_editor_download_icon");
                        _downloadIcon = (_local_11.content as BitmapData);
                    };
                    return (_downloadIcon);
                };
            };
            if (!_SafeStr_1280)
            {
                return (null);
            };
            _local_4 = new BitmapData(_SafeStr_1279.width, _SafeStr_1279.height, true, 0xFFFFFF);
            var _local_5:int;
            var _local_9:Boolean;
            var _local_14:Array = partSet.parts.concat().sort(sortByDrawOrder);
            for each (_local_3 in _local_14)
            {
                _local_12 = null;
                if (_local_9)
                {
                    _local_10 = ((((((("h_std_" + _local_3.type) + "_") + _local_3.id) + "_") + THUMB_DIRECTIONS[_local_5]) + "_") + "0");
                    _local_12 = (_SafeStr_1280.getAssetByName(_local_10) as BitmapDataAsset);
                }
                else
                {
                    _local_5 = 0;
                    while (((!(_local_9)) && (_local_5 < THUMB_DIRECTIONS.length)))
                    {
                        _local_10 = ((((((("h_std_" + _local_3.type) + "_") + _local_3.id) + "_") + THUMB_DIRECTIONS[_local_5]) + "_") + "0");
                        _local_12 = (_SafeStr_1280.getAssetByName(_local_10) as BitmapDataAsset);
                        if (((_local_12) && (_local_12.content)))
                        {
                            _local_9 = true;
                        }
                        else
                        {
                            _local_5++;
                        };
                    };
                };
                if (_local_12)
                {
                    _local_1 = BitmapData(_local_12.content);
                    _local_7 = ((-1 * _local_12.offset.x) - _SafeStr_1279.x);
                    _local_8 = ((-1 * _local_12.offset.y) - _SafeStr_1279.y);
                    _local_13 = null;
                    if (((_useColors) && (_local_3.colorLayerIndex > 0)))
                    {
                        _local_2 = _colors[(_local_3.colorLayerIndex - 1)];
                        if (_local_2 != null)
                        {
                            _local_13 = _local_2.colorTransform;
                        };
                    };
                    if (_local_13)
                    {
                        _local_6 = new Rectangle(_local_7, _local_8, _local_12.rectangle.width, _local_12.rectangle.height);
                        _local_4.draw((_local_12.content as BitmapData), new Matrix(1, 0, 0, 1, (-(_local_12.rectangle.x) + _local_7), (-(_local_12.rectangle.y) + _local_8)), _local_13, null, _local_6);
                    }
                    else
                    {
                        _local_4.copyPixels(_local_1, _local_12.rectangle, new Point(_local_7, _local_8), null, null, true);
                    };
                };
            };
            return (_local_4);
        }

        private function setAlpha(_arg_1:BitmapData, _arg_2:Number):BitmapData
        {
            var _local_3:Rectangle = new Rectangle(0, 0, _arg_1.width, _arg_1.height);
            var _local_4:ColorTransform = new ColorTransform();
            _local_4.alphaMultiplier = _arg_2;
            _arg_1.colorTransform(_local_3, _local_4);
            return (_arg_1);
        }

        private function sortByDrawOrder(_arg_1:IFigurePart, _arg_2:IFigurePart):Number
        {
            var _local_3:Number = DRAW_ORDER.indexOf(_arg_1.type);
            var _local_4:Number = DRAW_ORDER.indexOf(_arg_2.type);
            if (_local_3 < _local_4)
            {
                return (-1);
            };
            if (_local_3 > _local_4)
            {
                return (1);
            };
            if (_arg_1.index < _arg_2.index)
            {
                return (-1);
            };
            if (_arg_1.index > _arg_2.index)
            {
                return (1);
            };
            return (0);
        }

        public function avatarImageReady(_arg_1:String):void
        {
            if (!analyzePartLayers())
            {
                return;
            };
            updateThumbVisualization();
        }

        public function get isDisabledForWearing():Boolean
        {
            return (_isDisabledForWearing);
        }


    }
}

