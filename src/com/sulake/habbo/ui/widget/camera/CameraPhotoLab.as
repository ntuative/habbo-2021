package com.sulake.habbo.ui.widget.camera
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import flash.display.BitmapData;
    import com.sulake.core.window.components.ITextWindow;
    import com.sulake.core.utils.Map;
    import com.sulake.core.window.components.IScrollableGridWindow;
    import flash.display.Sprite;
    import flash.net.FileReference;
    import com.sulake.habbo.localization.IHabboLocalizationManager;
    import com.sulake.core.window.components.IFrameWindow;
    import flash.utils.setTimeout;
    import com.sulake.habbo.quest.IHabboQuestEngine;
    import com.sulake.core.window.components.IRegionWindow;
    import flash.geom.Matrix;
    import flash.display.Bitmap;
    import com.sulake.core.window.IWindow;
    import flash.geom.Point;
    import com.sulake.core.window.components.IDisplayObjectWrapper;
    import com.sulake.core.window.components._SafeStr_124;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.events.WindowKeyboardEvent;
    import com.sulake.habbo.tracking.HabboTracking;
    import flash.events.MouseEvent;
    import com.sulake.habbo.communication.messages.parser.camera.CameraPublishStatusMessageEvent;
    import com.sulake.habbo.communication.messages.parser.camera.CompetitionStatusMessageEvent;
    import flash.globalization.DateTimeFormatter;
    import com.sulake.core.utils.images.PNGEncoder;
    import flash.utils.ByteArray;
    import flash.geom.ColorTransform;
    import com.sulake.core.window.events.WindowMouseEvent;
    import __AS3__.vec.Vector;

    public class CameraPhotoLab implements IDisposable 
    {

        private static var TEXT_WIDTH_MARGIN:int = 6;
        private static var _SafeStr_3942:PhotoPurchaseConfirmationDialog;

        private var _SafeStr_1324:CameraWidget;
        private var _window:IWindowContainer;
        private var _disposed:Boolean = false;
        private var _SafeStr_3943:IBitmapWrapperWindow;
        private var _SafeStr_3944:BitmapData;
        private var _SafeStr_3945:CameraFxStrengthSlider;
        private var _sliderEffectInfo:ITextWindow;
        private var _SafeStr_3946:CameraEffect;
        private var _SafeStr_3947:Map = new Map();
        private var _itemGrid:IScrollableGridWindow;
        private var _SafeStr_3948:Sprite;
        private var _SafeStr_3949:Map = new Map();
        private var _captionInputKeyEvents:int = 0;
        private var _latestCaption:String = "";
        private var _SafeStr_3950:Boolean = false;
        private var _SafeStr_3951:FileReference = new FileReference();

        public function CameraPhotoLab(_arg_1:CameraWidget)
        {
            _SafeStr_1324 = _arg_1;
        }

        public static function preloadEffects(_arg_1:String, _arg_2:String, _arg_3:IHabboLocalizationManager):void
        {
            var _local_5:Array = [];
            var _local_4:Map = CameraEffect.getEffects(_arg_2, _arg_3);
            for each (var _local_6:CameraEffect in _local_4)
            {
                if (((_local_6.type == "composite") || (_local_6.type == "frame")))
                {
                    _local_5.push(_local_6.name);
                };
            };
            CameraFxPreloader.init(_arg_1, _local_5);
        }


        public function dispose():void
        {
            if (_disposed)
            {
                return;
            };
            if (_SafeStr_3942)
            {
                _SafeStr_3942.hide();
            };
            CameraEffect.resetAllEffects();
            _SafeStr_3944 = null;
            _SafeStr_1324 = null;
            _SafeStr_3943 = null;
            if (_SafeStr_3945 != null)
            {
                _SafeStr_3945.dispose();
                _SafeStr_3945 = null;
            };
            _sliderEffectInfo = null;
            _SafeStr_3946 = null;
            _SafeStr_3947 = null;
            _SafeStr_3949 = null;
            _disposed = true;
            if (_window)
            {
                _window.dispose();
            };
            _window = null;
        }

        public function get disposed():Boolean
        {
            return (_disposed);
        }

        private function setImageAndFilterButtons(_arg_1:BitmapData):void
        {
            _SafeStr_3944 = _arg_1.clone();
            _SafeStr_3943.bitmap = _arg_1;
            buildFilterButtons();
        }

        internal function setSelectedFxValue(_arg_1:Number):void
        {
            if (_SafeStr_3946)
            {
                _SafeStr_3946.value = _arg_1;
                updateSliderEffectInfo();
                renderAllEffects();
            };
        }

        private function updateSliderEffectInfo():void
        {
            _sliderEffectInfo.text = (((_SafeStr_3946.description + " ") + (_SafeStr_3946.getEffectStrength() * 100)) + "%");
            _sliderEffectInfo.width = (_sliderEffectInfo.textWidth + TEXT_WIDTH_MARGIN);
        }

        internal function setCaptionText(_arg_1:String):void
        {
            ITextWindow(_window.findChildByName("captionInput")).text = _arg_1;
        }

        private function buildTypeButtons():void
        {
            var _local_5:int;
            _local_5 = 6;
            var _local_3:int;
            _local_3 = 2;
            if (_SafeStr_3949.length > 0)
            {
                return;
            };
            var _local_1:int = ((_window as IFrameWindow).margins.left + _itemGrid.x);
            var _local_2:IWindowContainer = createTypeButton("colormatrix", "camera_icon_colorfilter");
            _local_2.x = (_local_1 + ((_itemGrid.width - ((2 * (_local_2.width + 6)) - 6)) / 2));
            _local_2.y = 50;
            _window.addChild(_local_2);
            var _local_4:IWindowContainer = createTypeButton("composite", "camera_icon_compositefilter");
            _local_4.x = (_local_2.right + 6);
            _local_4.y = _local_2.y;
            _window.addChild(_local_4);
        }

        private function buildFilterButtons():void
        {
            var _local_1:IWindowContainer;
            var _local_5:String;
            if (CameraFxPreloader.preloadFinished() == false)
            {
                (setTimeout(buildFilterButtons, 200));
            };
            var _local_6:int;
            var _local_7:IHabboQuestEngine = _SafeStr_1324.handler.roomDesktop.questEngine;
            if (_local_7 != null)
            {
                _local_6 = _local_7.getAchievementLevel("explore", "ACH_CameraPhotoCount");
                if (_local_6 == 0)
                {
                    _local_6 = _local_7.getAchievementLevel("archive", "ACH_CameraPhotoCount");
                };
            };
            var _local_2:Map = CameraEffect.getEffects(_SafeStr_1324.component.getProperty("camera.available.effects"), _SafeStr_1324.localizations);
            for each (var _local_4:CameraEffect in _local_2)
            {
                _local_1 = createFxButton(_local_4, _SafeStr_3944.clone(), _local_6);
                if (_local_1)
                {
                    _local_5 = _local_4.description;
                    if (_local_6 < _local_4._SafeStr_629)
                    {
                        _local_5 = ((_SafeStr_1324.localizations.getLocalization("camera.effect.required.level") + " ") + _local_4._SafeStr_629);
                    };
                    IRegionWindow(_local_1).toolTipCaption = _local_5;
                };
            };
            var _local_3:IWindowContainer = (_window.findChildByName("slider_container") as IWindowContainer);
            _SafeStr_3945 = new CameraFxStrengthSlider(this, _local_3, _SafeStr_1324.windowManager.assets);
            _SafeStr_3945.disable();
            CameraEffect.setMaxValue(_SafeStr_3945.getScale());
            setFilterType("colormatrix");
        }

        private function createTypeButton(_arg_1:String, _arg_2:String):IWindowContainer
        {
            var _local_3:IRegionWindow = (_SafeStr_1324.getXmlWindow("camera_typebutton") as IRegionWindow);
            var _local_4:IBitmapWrapperWindow = (_local_3.findChildByName("icon") as IBitmapWrapperWindow);
            _local_4.bitmap = (_SafeStr_1324.windowManager.assets.getAssetByName(_arg_2).content as BitmapData).clone();
            _local_3.name = ("typebutton," + _arg_1);
            _local_3.toolTipCaption = _arg_1;
            _SafeStr_3949.add(_arg_1, _local_3);
            return (_local_3);
        }

        private function createFxButton(_arg_1:CameraEffect, _arg_2:BitmapData, _arg_3:int):IWindowContainer
        {
            var _local_7:IBitmapWrapperWindow;
            var _local_5:Number;
            var _local_8:Matrix;
            var _local_9:Bitmap;
            var _local_6:IWindow;
            var _local_4:IWindowContainer = (_SafeStr_1324.getXmlWindow("camera_filterbutton") as IWindowContainer);
            if (_arg_3 >= _arg_1._SafeStr_629)
            {
                _local_7 = (_local_4.findChildByName("content") as IBitmapWrapperWindow);
                _local_7.bitmap = new BitmapData(_local_7.width, _local_7.height, true, 0);
                _local_5 = (_local_7.width / _arg_2.width);
                _local_8 = new Matrix();
                _local_8.scale(_local_5, _local_5);
                _local_9 = new Bitmap(_arg_2, "auto", true);
                switch (_arg_1.type)
                {
                    case "colormatrix":
                        _arg_2.applyFilter(_arg_2, _arg_2.rect, new Point(0, 0), _arg_1.getColorMatrixFilter(true));
                        break;
                    case "composite":
                        if (CameraFxPreloader.getImage(_arg_1.name) == null)
                        {
                            return (null);
                        };
                        _arg_2.draw(CameraFxPreloader.getImage(_arg_1.name), null, null, _arg_1._SafeStr_630, null, true);
                        break;
                    case "frame":
                        if (CameraFxPreloader.getImage(_arg_1.name) == null)
                        {
                            return (null);
                        };
                        _arg_2.draw(CameraFxPreloader.getImage(_arg_1.name), null, null, null, null, true);
                };
                _local_7.bitmap.draw(_local_9, _local_8, null, null, null, true);
                _local_4.procedure = effectButtonClick;
            }
            else
            {
                _local_6 = (_local_4.findChildByName("lock_indicator") as IWindow);
                _local_6.visible = true;
            };
            _local_4.name = _arg_1.name;
            _arg_1.button = _local_4;
            _SafeStr_3947[_local_4.name] = _arg_1;
            return (_local_4);
        }

        public function openPhotoLab(_arg_1:BitmapData):void
        {
            _window = (_SafeStr_1324.getXmlWindow("camera_editor") as IWindowContainer);
            _window.center();
            if (_SafeStr_1324.component.getProperty("camera.effects.enabled") != "true")
            {
                openPurchaseConfirmationDialog(null);
                return;
            };
            _itemGrid = (_window.findChildByName("item_grid") as IScrollableGridWindow);
            _itemGrid.spacing = 7;
            _SafeStr_3943 = (_window.findChildByName("image") as IBitmapWrapperWindow);
            _window.procedure = windowEventHandler;
            var _local_10:ITextWindow = ITextWindow(_window.findChildByName("captionInput"));
            _local_10.procedure = captionProcedure;
            var _local_6:IDisplayObjectWrapper = (_window.findChildByName("purchase_display_object") as IDisplayObjectWrapper);
            _SafeStr_3948 = new Sprite();
            _SafeStr_3948.graphics.beginFill(0xFF0000, 0);
            _SafeStr_3948.graphics.drawRect(0, 0, _local_6.width, _local_6.height);
            _local_6.setDisplayObject(_SafeStr_3948);
            _SafeStr_3948.addEventListener("click", openPurchaseConfirmationDialog);
            var _local_7:IRegionWindow = (_window.findChildByName("zoom_button") as IRegionWindow);
            var _local_11:_SafeStr_124 = (_local_7.getChildByName("centerizer") as _SafeStr_124);
            var _local_5:ITextWindow = (_local_11.getChildByName("zoom_text") as ITextWindow);
            _local_5.width = (_local_5.textWidth + TEXT_WIDTH_MARGIN);
            var _local_8:IRegionWindow = (_window.findChildByName("save_button") as IRegionWindow);
            var _local_4:_SafeStr_124 = (_local_8.getChildByName("centerizer") as _SafeStr_124);
            var _local_9:ITextWindow = (_local_4.getChildByName("save_text") as ITextWindow);
            _local_9.width = (_local_9.textWidth + TEXT_WIDTH_MARGIN);
            var _local_2:IDisplayObjectWrapper = (_window.findChildByName("save_click_catcher") as IDisplayObjectWrapper);
            var _local_3:Sprite = new Sprite();
            _local_3.graphics.beginFill(0xFF0000, 0);
            _local_3.graphics.drawRect(0, 0, _local_2.width, _local_2.height);
            _local_2.setDisplayObject(_local_3);
            _local_3.addEventListener("click", offerSaveAsFile);
            buildTypeButtons();
            setImageAndFilterButtons(_arg_1);
            _sliderEffectInfo = (_window.findChildByName("slider_effect_info") as ITextWindow);
            CameraEffect.resetAllEffects();
        }

        private function effectButtonClick(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            var _local_3:CameraEffect;
            if (_arg_1.type != "WME_CLICK")
            {
                return;
            };
            if (_arg_2.name == "remove_effect_button")
            {
                if (_SafeStr_3947.hasKey(_arg_2.parent.name))
                {
                    _local_3 = _SafeStr_3947[_arg_2.parent.name];
                    _local_3.setChosen(false);
                    if (_SafeStr_3946 == _local_3)
                    {
                        _SafeStr_3945.disable();
                        _SafeStr_3946 = null;
                    };
                    renderAllEffects();
                    return;
                };
            };
            if (_SafeStr_3947.hasKey(_arg_2.name))
            {
                setActiveEffect(_SafeStr_3947[_arg_2.name]);
            };
        }

        private function captionProcedure(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type == "WKE_KEY_DOWN")
            {
                if (((WindowKeyboardEvent(_arg_1).ctrlKey) || (WindowKeyboardEvent(_arg_1).charCode == 0)))
                {
                    _captionInputKeyEvents = 0;
                }
                else
                {
                    _captionInputKeyEvents++;
                };
            }
            else
            {
                if (_arg_1.type == "WKE_KEY_UP")
                {
                    _captionInputKeyEvents = 0;
                }
                else
                {
                    if (_arg_1.type == "WE_CHANGE")
                    {
                        if (_captionInputKeyEvents == 1)
                        {
                            _latestCaption = ITextWindow(_window.findChildByName("captionInput")).text;
                        }
                        else
                        {
                            setCaptionText(_latestCaption);
                        };
                        _captionInputKeyEvents = 0;
                    };
                };
            };
        }

        private function openPurchaseConfirmationDialog(_arg_1:MouseEvent):void
        {
            if (_SafeStr_3942)
            {
                _SafeStr_3942.hide();
            };
            if (_SafeStr_1324.container.sessionDataManager.isAccountSafetyLocked())
            {
                _SafeStr_1324.windowManager.alert("${generic.alert.title}", "${notifications.text.safety_locked}", 0, null);
                if (_SafeStr_1324.component.getProperty("camera.effects.enabled") != "true")
                {
                    dispose();
                };
                return;
            };
            _SafeStr_3942 = new PhotoPurchaseConfirmationDialog(_SafeStr_1324, ITextWindow(_window.findChildByName("captionInput")).text);
            var _local_2:Boolean = _SafeStr_1324.sendPhotoData();
            _SafeStr_3942.setPrices(_SafeStr_1324.handler.creditPrice, _SafeStr_1324.handler.ducketPrice, _SafeStr_1324.handler.publishDucketPrice);
            HabboTracking.getInstance().trackEventLog("Stories", "camera", "stories.photo.purchase_dialog_opened");
            if (!_local_2)
            {
                _SafeStr_3942.setRenderingFailed();
                _SafeStr_1324.windowManager.alert("${generic.alert.title}", "${camera.alert.too_much_stuff}", 0, null);
            };
            hide();
        }

        public function hide():void
        {
            _window.visible = false;
        }

        public function show():void
        {
            _window.visible = true;
        }

        public function closePurchaseConfirmation():void
        {
            if (_SafeStr_3942)
            {
                _SafeStr_3942.hide();
                _SafeStr_3942 = null;
            };
        }

        internal function animateSuccessfulPurchase():void
        {
            if (_SafeStr_3942)
            {
                _SafeStr_3942.animateIconToToolbar();
            };
        }

        public function publishingStatus(_arg_1:CameraPublishStatusMessageEvent):void
        {
            if (_SafeStr_3942)
            {
                _SafeStr_3942.publishingStatus(_arg_1);
            };
        }

        public function competitionStatus(_arg_1:CompetitionStatusMessageEvent):void
        {
            if (_SafeStr_3942)
            {
                _SafeStr_3942.competitionStatus(_arg_1);
            };
        }

        private function offerSaveAsFile(_arg_1:MouseEvent):void
        {
            var _local_2:DateTimeFormatter;
            var _local_4:String;
            var _local_3:BitmapData = _SafeStr_3943.bitmap.clone();
            var _local_5:ByteArray = PNGEncoder.encode(_local_3);
            try
            {
                _local_2 = new DateTimeFormatter("i-default");
                _local_2.setDateTimePattern("yyyy-MM-dd_HH-mm-ss");
                _local_4 = (("Habbo_" + _local_2.format(new Date())) + ".png");
                _SafeStr_3951.save(_local_5, _local_4);
            }
            catch(error:Error)
            {
            };
        }

        public function logChosenEffects():void
        {
            for each (var _local_1:CameraEffect in _SafeStr_3947)
            {
                if (_local_1.isOn)
                {
                    HabboTracking.getInstance().trackEventLog("Stories", "camera", "stories.photo.effect.chosen", _local_1.name);
                };
            };
        }

        private function windowEventHandler(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if ((((_disposed) || (!(_window))) || (!(_arg_1.type == "WME_CLICK"))))
            {
                return;
            };
            switch (_arg_2.name)
            {
                case "cancel_button":
                    _SafeStr_1324.startTakingPhoto("effectEditorCancel");
                    dispose();
                    break;
                case "header_button_close":
                    dispose();
                    break;
                case "help_button":
                    _SafeStr_1324.component.context.createLinkEvent("habbopages/camera");
                    break;
                case "save_button":
                    break;
                case "slider_container":
                    break;
                case "zoom_button":
                    _SafeStr_3950 = (!(_SafeStr_3950));
                    renderAllEffects();
                    break;
                default:
                    _SafeStr_3945.disable();
                    if (_SafeStr_3946 != null)
                    {
                        _SafeStr_3946.turnOffHighlight();
                    };
            };
            if (_arg_2.name.indexOf("typebutton") != -1)
            {
                setFilterType(_arg_2.name.split(",")[1]);
            };
        }

        private function setActiveEffect(_arg_1:CameraEffect):void
        {
            if (_SafeStr_3946 != null)
            {
                _SafeStr_3946.turnOffHighlight();
            };
            _SafeStr_3946 = _arg_1;
            _SafeStr_3946.setChosen(true);
            if (_arg_1.usesEffectStrength())
            {
                _SafeStr_3945.enable();
                _SafeStr_3945.setValue(_arg_1.value);
                updateSliderEffectInfo();
            }
            else
            {
                _SafeStr_3945.disable();
            };
            if (_arg_1.allowsOnlyOneInstance())
            {
                turnOffOtherEffectsOfSameType(_arg_1);
            };
            renderAllEffects();
        }

        private function turnOffOtherEffectsOfSameType(_arg_1:CameraEffect):void
        {
            for each (var _local_2:CameraEffect in _SafeStr_3947)
            {
                if (((_local_2.type == _arg_1.type) && (!(_local_2 == _arg_1))))
                {
                    _local_2.setChosen(false);
                };
            };
        }

        private function setFilterType(_arg_1:String):void
        {
            if (_SafeStr_3946 != null)
            {
                _SafeStr_3946.turnOffHighlight();
            };
            _itemGrid.removeGridItems();
            for each (var _local_2:CameraEffect in _SafeStr_3947)
            {
                if (_local_2.type == _arg_1)
                {
                    _itemGrid.addGridItem(_local_2.button);
                };
            };
            highlightSelectedButtonType(_arg_1);
        }

        private function highlightSelectedButtonType(_arg_1:String):void
        {
            var _local_3:IWindow;
            for each (var _local_2:IWindowContainer in _SafeStr_3949)
            {
                _local_3 = _local_2.findChildByName("active_border");
                _local_3.visible = (_local_2.name == ("typebutton," + _arg_1));
            };
        }

        private function renderAllEffects():void
        {
            var _local_2:ColorTransform;
            var _local_5:Matrix;
            var _local_3:BitmapData;
            var _local_1:BitmapData = _SafeStr_3944.clone();
            if (_SafeStr_3950)
            {
                _local_5 = new Matrix();
                _local_5.a = 2;
                _local_5.d = 2;
                _local_5.tx = (-(_local_1.width) / 2);
                _local_5.ty = (-(_local_1.height) / 2);
                _local_3 = new BitmapData(_local_1.width, _local_1.height);
                _local_3.draw(_local_1, _local_5);
                _local_1 = _local_3;
            };
            for each (var _local_4:CameraEffect in _SafeStr_3947)
            {
                if (_local_4.isOn)
                {
                    if (_local_4.type == "colormatrix")
                    {
                        _local_1.applyFilter(_local_1, _local_1.rect, new Point(0, 0), _local_4.getColorMatrixFilter());
                    };
                    if (_local_4.type == "composite")
                    {
                        _local_2 = new ColorTransform(1, 1, 1, _local_4.getEffectStrength());
                        _local_1.draw(CameraFxPreloader.getImage(_local_4.name), null, _local_2, _local_4._SafeStr_630);
                    };
                };
            };
            for each (var _local_6:CameraEffect in _SafeStr_3947)
            {
                if (((_local_6.isOn) && (_local_6.type == "frame")))
                {
                    _local_1.draw(CameraFxPreloader.getImage(_local_6.name));
                };
            };
            _SafeStr_3943.bitmap = _local_1;
            _SafeStr_3943.invalidate();
        }

        protected function onClose(_arg_1:WindowMouseEvent):void
        {
            dispose();
        }

        public function setRenderedPhotoUrl(_arg_1:String):void
        {
            if (_SafeStr_3942)
            {
                _SafeStr_3942.setImageUrl(_arg_1);
            };
        }

        public function getEffectDataJson():String
        {
            var _local_2:Object;
            var _local_1:Vector.<Object> = new Vector.<Object>();
            for each (var _local_3:CameraEffect in _SafeStr_3947)
            {
                if (((_local_3.isOn) && (!(_local_3.type == "frame"))))
                {
                    _local_2 = {};
                    _local_2.name = _local_3.name;
                    _local_2.alpha = (_local_3.getEffectStrength() * 0xFF);
                    _local_1.push(_local_2);
                };
            };
            for each (var _local_4:CameraEffect in _SafeStr_3947)
            {
                if (((_local_4.isOn) && (_local_4.type == "frame")))
                {
                    _local_2 = {};
                    _local_2.name = _local_4.name;
                    _local_1.push(_local_2);
                };
            };
            return (JSON.stringify(_local_1));
        }

        public function getZoom():int
        {
            return ((_SafeStr_3950) ? 2 : 1);
        }


    }
}

