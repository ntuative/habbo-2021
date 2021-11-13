package com.sulake.habbo.ui.widget.furniture.externalimage
{
    import com.sulake.habbo.ui.widget.RoomWidgetBase;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import com.sulake.core.window.components.IHTMLTextWindow;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.components.IRegionWindow;
    import com.sulake.core.window.components.ILabelWindow;
    import flash.text.TextField;
    import com.sulake.core.assets.loaders.BitmapFileLoader;
    import flash.display.Bitmap;
    import com.sulake.habbo.inventory.IHabboInventory;
    import com.sulake.habbo.help.IHabboHelp;
    import com.sulake.habbo.room.IRoomEngine;
    import com.sulake.core.runtime.Component;
    import com.sulake.core.window.components.IDisplayObjectWrapper;
    import com.sulake.habbo.ui.IRoomWidgetHandler;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.habbo.localization.IHabboLocalizationManager;
    import com.sulake.habbo.ui.handler.ExternalImageWidgetHandler;
    import __AS3__.vec.Vector;
    import com.sulake.room.object.IRoomObject;
    import com.sulake.habbo.inventory.items.IFurnitureItem;
    import com.sulake.core.window.components.ITextWindow;
    import flash.display.BitmapData;
    import com.adobe.serialization.json.JSONDecoder;
    import flash.net.URLRequest;
    import com.sulake.core.assets.loaders.AssetLoaderEvent;
    import flash.geom.Matrix;
    import flash.geom.ColorTransform;
    import flash.net.URLLoader;
    import flash.events.HTTPStatusEvent;
    import flash.events.Event;
    import flash.display.Stage;
    import com.sulake.habbo.window.utils._SafeStr_126;
    import com.sulake.habbo.toolbar.events.HabboToolbarEvent;
    import com.sulake.core.window.components.ITextFieldWindow;
    import com.sulake.habbo.window.utils.AlertDialogCaption;
    import com.sulake.habbo.utils.HabboWebTools;
    import com.sulake.habbo.tracking.HabboTracking;
    import flash.net.navigateToURL;
    import com.sulake.habbo.communication.messages.outgoing.users.GetExtendedProfileMessageComposer;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.habbo.utils.StringUtil;
    import com.sulake.core.window.events.WindowLinkEvent;
    import com.sulake.core.window.components.ISelectableWindow;
    import com.sulake.habbo.window.widgets.IIlluminaInputWidget;
    import com.sulake.core.window.components.ISelectorWindow;
    import com.sulake.core.window.components.IWidgetWindow;

    public class ExternalImageWidget extends RoomWidgetBase
    {

        private static const TYPE_PHOTO_POSTER:String = "photo_poster";
        private static const TYPE_SELFIE:String = "selfie";
        private static const TYPE_LEGACY:String = "legacy";
        private static const HORIZONTAL_ITEM_SPACING:int = 10;
        private static const VERTICAL_SPACE:int = 71;

        private var _window:IWindowContainer;
        private var _SafeStr_1355:IBitmapWrapperWindow;
        private var _moderationText:IHTMLTextWindow;
        private var _makeOwnButton:IWindow;
        private var _closeButton:IWindow;
        private var _deleteButton:IWindowContainer;
        private var _bgBorder:IWindow;
        private var _buttonContainer:IWindowContainer;
        private var _shareArea:IWindowContainer;
        private var _shareButton:IWindow;
        private var _senderNameButton:IRegionWindow;
        private var _SafeStr_4091:ILabelWindow;
        private var _SafeStr_4090:TextField;
        private var _SafeStr_4092:ILabelWindow;
        private var _SafeStr_4093:BitmapFileLoader;
        private var _SafeStr_4094:Bitmap;
        private var _inventory:IHabboInventory;
        private var _SafeStr_4095:int;
        private var _SafeStr_4096:String;
        private var _caption:String;
        private var _SafeStr_1721:int;
        private var _SafeStr_4097:String;
        private var _reportImagebutton:IWindowContainer;
        private var _SafeStr_4098:String;
        private var _SafeStr_4099:IBitmapWrapperWindow;
        private var _habboHelp:IHabboHelp;
        private var _roomEngine:IRoomEngine;
        private var reportWindow:IWindowContainer;
        private var _SafeStr_4100:int = 0;
        private var _SafeStr_4101:Boolean = false;
        private var _SafeStr_659:Component;

        public function ExternalImageWidget(_arg_1:IRoomWidgetHandler, _arg_2:IHabboWindowManager, _arg_3:IAssetLibrary, _arg_4:IHabboLocalizationManager, _arg_5:IHabboInventory, _arg_6:IHabboHelp, _arg_7:IRoomEngine, _arg_8:Component)
        {
            super(_arg_1, _arg_2, _arg_3, _arg_4);
            var _local_9:IDisplayObjectWrapper = null;
            _window = (_arg_2.buildFromXML((_arg_3.getAssetByName("stories_image_widget_xml").content as XML)) as IWindowContainer);
            ownHandler.widget = this;
            _closeButton = (_window.findChildByName("closebutton") as IWindow);
            _SafeStr_1355 = (_window.findChildByName("imageLoader") as IBitmapWrapperWindow);
            _moderationText = (_window.findChildByName("moderationText") as IHTMLTextWindow);
            _moderationText.addEventListener("WE_LINK", onClickModerationInfoLink);
            _shareArea = (_window.findChildByName("shareArea") as IWindowContainer);
            _deleteButton = (_window.findChildByName("removeButtonContainer") as IWindowContainer);
            _makeOwnButton = (_window.findChildByName("makeOwnButton") as IWindow);
            _shareButton = (_window.findChildByName("shareButtonContainer") as IWindow);
            _bgBorder = (_window.findChildByName("bgBorder") as IWindow);
            _senderNameButton = (_window.findChildByName("senderNameButton") as IRegionWindow);
            _SafeStr_4091 = (_window.findChildByName("senderName") as ILabelWindow);
            _SafeStr_4090 = new TextField();
            if (ownHandler.container.roomSession.roomControllerLevel == 5)
            {
                _local_9 = (_window.findChildByName("name_copy_wrapper") as IDisplayObjectWrapper);
                _SafeStr_4090.textColor = 10061943;
                _SafeStr_4090.text = "";
                _local_9.setDisplayObject(_SafeStr_4090);
            };
            _SafeStr_4092 = (_window.findChildByName("creationDate") as ILabelWindow);
            _buttonContainer = (_window.findChildByName("buttonContainer") as IWindowContainer);
            _inventory = _arg_5;
            _habboHelp = _arg_6;
            _roomEngine = _arg_7;
            _reportImagebutton = (_window.findChildByName("reportButtonContainer") as IWindowContainer);
            _window.procedure = onWindowEvent;
            _window.center();
            _shareArea.visible = false;
            _SafeStr_659 = _arg_8;
            hide();
        }

        private function get ownHandler():ExternalImageWidgetHandler
        {
            return (_SafeStr_3915 as ExternalImageWidgetHandler);
        }

        public function showWithRoomObject(_arg_1:IRoomObject):void
        {
            _SafeStr_4095 = _arg_1.getId();
            _SafeStr_4098 = _arg_1.getType();
            _SafeStr_4101 = false;
            _deleteButton.visible = ownHandler.hasRightsToRemove();
            if (getType() == "photo_poster")
            {
                _reportImagebutton.visible = true;
            }
            else
            {
                _reportImagebutton.visible = ownHandler.isSelfieReportingEnabled();
            };
            show(_arg_1.getModel().getString("furniture_data"));
            var _local_2:Vector.<IRoomObject> = getWallItemsOfCurrentTypeInRoom();
            if (_local_2.indexOf(_arg_1) != -1)
            {
                _SafeStr_4100 = _local_2.indexOf(_arg_1);
            };
        }

        public function showWithFurniID(_arg_1:int):void
        {
            var _local_2:IFurnitureItem = _inventory.getWallItemById(_arg_1);
            if (_local_2)
            {
                _SafeStr_4095 = _arg_1;
                _SafeStr_4098 = _roomEngine.getWallItemType(_local_2.type);
                _SafeStr_4101 = true;
                _deleteButton.visible = false;
                _reportImagebutton.visible = false;
                show(_local_2.stuffData.getLegacyString());
            };
        }

        private function show(_arg_1:String):void
        {
            if (ownHandler.storiesImageUrlBase == "disabled")
            {
                return;
            };
            clearImage();
            if (_arg_1 != null)
            {
                readFurniJson(_arg_1);
            };
        }

        private function showNext():void
        {
            var _local_1:Vector.<IRoomObject> = getWallItemsOfCurrentTypeInRoom();
            if (_local_1.length > 0)
            {
                _SafeStr_4100++;
                if (_SafeStr_4100 > (_local_1.length - 1))
                {
                    _SafeStr_4100 = 0;
                };
                showWithRoomObject(_local_1[_SafeStr_4100]);
            };
        }

        private function showPrevious():void
        {
            var _local_1:Vector.<IRoomObject> = getWallItemsOfCurrentTypeInRoom();
            if (_local_1.length > 0)
            {
                _SafeStr_4100--;
                if (_SafeStr_4100 < 0)
                {
                    _SafeStr_4100 = (_local_1.length - 1);
                };
                showWithRoomObject(_local_1[_SafeStr_4100]);
            };
        }

        private function getWallItemsOfCurrentTypeInRoom():Vector.<IRoomObject>
        {
            var _local_2:Vector.<IRoomObject> = new Vector.<IRoomObject>();
            var _local_3:Array = _roomEngine.getObjectsByCategory(20);
            for each (var _local_1:IRoomObject in _local_3)
            {
                if (_local_1.getType() == _SafeStr_4098)
                {
                    _local_2.push(_local_1);
                };
            };
            return (_local_2);
        }

        private function clearImage():void
        {
            _SafeStr_4096 = null;
            _caption = "";
            var _local_1:ITextWindow = (_window.findChildByName("captionText") as ITextWindow);
            _local_1.text = "";
            _senderNameButton.visible = false;
            _SafeStr_1721 = 0;
            _SafeStr_4091.caption = "";
            _SafeStr_4090.text = "";
            _SafeStr_4092.caption = "";
            _SafeStr_4097 = null;
            _moderationText.visible = false;
            drawImage(new Bitmap(new BitmapData((_SafeStr_1355.width - 2), (_SafeStr_1355.height - 2), false, 0)));
        }

        private function readFurniJson(_arg_1:String):void
        {
            try
            {
                _SafeStr_4096 = new JSONDecoder(_arg_1, false).getValue().id;
                if (_SafeStr_4096)
                {
                    loadExternalData();
                    return;
                };
                loadPhoto(_arg_1, getImageUrl(new JSONDecoder(_arg_1, false).getValue()));
            }
            catch(error:Error)
            {
            };
        }

        private function getImageUrl(_arg_1:Object):String
        {
            var _local_3:String;
            var _local_2:String = getJsonValue(_arg_1, "w", "url");
            if (_local_2.indexOf("http") != 0)
            {
                _local_3 = "postcards/selfie/";
                if (getType() == "photo_poster")
                {
                    _local_3 = "";
                };
                if (_local_2.indexOf(".png") == -1)
                {
                    _local_2 = (_local_2 + ".png");
                };
                _local_2 = ((ownHandler.storiesImageUrlBase + _local_3) + _local_2);
            };
            return (_local_2);
        }

        private function loadPhoto(_arg_1:String, _arg_2:String):void
        {
            var _local_8:Object;
            var _local_3:IWindow;
            var _local_10:String;
            var _local_7:ITextWindow;
            try
            {
                _local_8 = new JSONDecoder(_arg_1, false).getValue();
            }
            catch(error:Error)
            {
                return;
            };
            if (!_arg_2)
            {
                _arg_2 = getImageUrl(_local_8);
            };
            _SafeStr_4093 = new BitmapFileLoader("image/png", new URLRequest(_arg_2));
            _SafeStr_4093.addEventListener("AssetLoaderEventComplete", onImageLoaded);
            var _local_4:String = getJsonValue(_local_8, "n", "creator_name");
            var _local_5:String = getJsonValue(_local_8, "s", "creator_id");
            var _local_11:String = getJsonValue(_local_8, "u", "unique_id");
            var _local_6:String = getJsonValue(_local_8, "t", "time");
            var _local_9:Date = new Date(_local_6);
            if (_local_4)
            {
                _SafeStr_4091.caption = _local_4;
                _senderNameButton.visible = true;
                _SafeStr_4090.text = _local_4;
                _SafeStr_1721 = int(_local_5);
                _SafeStr_4092.caption = ((((_local_9.date + "-") + (_local_9.month + 1)) + "-") + _local_9.fullYear);
            };
            if (((ownHandler.storiesImageShareUrl) && (ownHandler.storiesImageShareUrl.length > 4)))
            {
                _local_3 = (_window.findChildByName("urlField") as IWindow);
                _local_10 = ownHandler.storiesImageShareUrl.replace("%id%", _local_11);
                _local_3.caption = _local_10;
                _SafeStr_4097 = _local_10;
            };
            _caption = getJsonValue(_local_8, "m", "caption");
            if (_caption)
            {
                _local_7 = (_window.findChildByName("captionText") as ITextWindow);
                _local_7.text = _caption;
            };
        }

        private function getJsonValue(_arg_1:Object, _arg_2:String, _arg_3:String=null):String
        {
            var _local_4:String;
            _local_4 = _arg_1[_arg_2];
            if (((!(_local_4)) && (_arg_3)))
            {
                _local_4 = _arg_1[_arg_3];
            };
            return (_local_4);
        }

        private function onImageLoaded(_arg_1:AssetLoaderEvent):void
        {
            var _local_2:Bitmap;
            if (_SafeStr_4093)
            {
                _local_2 = (_SafeStr_4093.content as Bitmap);
                if (_local_2)
                {
                    _SafeStr_1355.width = (_local_2.width + 2);
                    _SafeStr_1355.height = (_local_2.height + 2);
                    drawImage(_local_2);
                };
            };
        }

        private function drawImage(_arg_1:Bitmap):void
        {
            _SafeStr_4094 = _arg_1;
            _SafeStr_1355.bitmap = new BitmapData(_SafeStr_1355.width, _SafeStr_1355.height, true, 0);
            _window.visible = true;
            var _local_3:IWindow = _window.findChildByName("previousButton");
            var _local_2:IWindow = _window.findChildByName("nextButton");
            _local_3.x = 10;
            var _local_6:Number = 0;
            _bgBorder.x = _local_6;
            _bgBorder.y = _local_6;
            _SafeStr_1355.x = ((10 * 2) + _local_3.width);
            _SafeStr_1355.y = 71;
            _local_6 = (_SafeStr_1355.height + (71 * 2));
            _window.height = _local_6;
            _bgBorder.height = _local_6;
            _local_6 = ((_SafeStr_1355.width + (10 * 4)) + (_local_3.width * 2));
            _window.width = _local_6;
            _bgBorder.width = _local_6;
            _senderNameButton.x = ((_SafeStr_1355.right - _senderNameButton.width) - 3);
            _senderNameButton.y = (_SafeStr_1355.bottom + 3);
            _SafeStr_4092.x = (_SafeStr_1355.x + 3);
            _local_6 = _SafeStr_1355.bottom;
            _senderNameButton.y = _local_6;
            _SafeStr_4092.y = _local_6;
            _buttonContainer.y = 0;
            _buttonContainer.x = (_bgBorder.right - _buttonContainer.width);
            _local_2.x = (_SafeStr_1355.right + 10);
            if (_SafeStr_4101)
            {
                _local_6 = Number(false);
                _local_3.visible = !!_local_6;
                _local_2.visible = !!_local_6;
            }
            else
            {
                _local_6 = Number(getWallItemsOfCurrentTypeInRoom().length > 1);
                _local_3.visible = !!_local_6;
                _local_2.visible =!!_local_6;
            };
            var _local_4:Matrix = new Matrix();
            var _local_5:ColorTransform = new ColorTransform();
            _local_5.color = 0;
            _local_4.ty = (_local_4.ty + 1);
            _SafeStr_1355.bitmap.draw(_arg_1, _local_4, _local_5);
            _local_4.tx = (_local_4.tx + 1);
            _local_4.ty = (_local_4.ty - 1);
            _SafeStr_1355.bitmap.draw(_arg_1, _local_4, _local_5);
            _local_4.ty = (_local_4.ty + 2);
            _SafeStr_1355.bitmap.draw(_arg_1, _local_4, _local_5);
            _local_4.ty = (_local_4.ty - 1);
            _local_4.tx = (_local_4.tx + 1);
            _SafeStr_1355.bitmap.draw(_arg_1, _local_4, _local_5);
            _local_4.tx = (_local_4.tx - 1);
            _SafeStr_1355.bitmap.draw(_arg_1, _local_4);
            _window.activate();
            updateWindowPosition();
        }

        private function loadExternalData():void
        {
            var _local_2:String = (ownHandler.extraDataServiceUrl + _SafeStr_4096);
            var _local_1:URLLoader = new URLLoader(new URLRequest(_local_2));
            _local_1.addEventListener("httpStatus", onExternalDataHttpStatus);
            _local_1.addEventListener("complete", onExternalDataLoaded);
            _local_1.addEventListener("ioError", onExternalDataError);
        }

        private function onExternalDataHttpStatus(_arg_1:HTTPStatusEvent):void
        {
            if (((_arg_1.status == 403) && (ownHandler.hasRightsToRemove())))
            {
                _moderationText.visible = true;
            };
        }

        private function onExternalDataError(_arg_1:Event):void
        {
            if (!_moderationText.visible)
            {
                Logger.log(("Extra data loading failed: " + _arg_1.toString()));
            };
        }

        private function onExternalDataLoaded(_arg_1:Event):void
        {
            var _local_2:String = URLLoader(_arg_1.target).data;
            if (_local_2.length == 0)
            {
                return;
            };
            loadPhoto(_local_2, null);
        }

        override public function dispose():void
        {
            if (!_window)
            {
                return;
            };
            _SafeStr_1355 = null;
            _closeButton = null;
            _bgBorder = null;
            _makeOwnButton = null;
            _deleteButton = null;
            _SafeStr_4093 = null;
            _inventory = null;
            _habboHelp = null;
            _roomEngine = null;
            _SafeStr_1721 = 0;
            _senderNameButton = null;
            _SafeStr_4090 = null;
            _buttonContainer = null;
            _shareArea = null;
            _window.procedure = null;
            _window.dispose();
            _SafeStr_659 = null;
            super.dispose();
            if (reportWindow)
            {
                reportWindow.destroy();
            };
        }

        public function hide():void
        {
            _window.visible = false;
        }

        private function updateWindowPosition():void
        {
            if (!_SafeStr_4094)
            {
                _window.center();
                return;
            };
            var _local_5:Stage = _SafeStr_659.context.displayObjectContainer.stage;
            var _local_1:Number = ((_local_5.stageWidth - 100) / _SafeStr_4094.width);
            var _local_3:Number = ((_local_5.stageHeight - 200) / _SafeStr_4094.height);
            if (_local_1 < 1)
            {
                _window.x = 50;
            }
            else
            {
                _window.x = ((_local_5.stageWidth - _window.width) * 0.5);
            };
            if (_local_3 < 1)
            {
                _window.y = 50;
            }
            else
            {
                _window.y = ((_local_5.stageHeight - _window.height) * 0.5);
            };
            var _local_4:IWindow = _window.findChildByName("previousButton");
            var _local_2:IWindow = _window.findChildByName("nextButton");
            var _local_6:int = _SafeStr_659.context.displayObjectContainer.stage.stageHeight;
            if (_bgBorder.height > _local_6)
            {
                var _local_7:Number = ((_local_6 / 2) - (_local_4.height / 2));
                _local_2.y = _local_7;
                _local_4.y = _local_7;
            }
            else
            {
                _local_7 = ((_bgBorder.height / 2) - (_local_4.height / 2));
                _local_2.y = _local_7;
                _local_4.y = _local_7;
            };
        }

        private function onWindowEvent(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            var _local_3:_SafeStr_126;
            var _local_4:HabboToolbarEvent;
            var _local_5:ITextFieldWindow;
            if (_arg_2 == _window)
            {
                switch (_arg_1.type)
                {
                    case "WE_PARENT_RESIZED":
                        updateWindowPosition();
                };
            };
            if (_arg_1.type != "WME_CLICK")
            {
                return;
            };
            switch (_arg_2.name)
            {
                case "closebutton":
                    hide();
                    return;
                case "removebutton":
                    _local_3 = windowManager.confirm(_SafeStr_819.getLocalization("inventory.remove.external_image_wallitem_header"), _SafeStr_819.getLocalization("inventory.remove.external_image_wallitem_body"), 0, onDeleteConfirm);
                    _local_3.setButtonCaption(16, new AlertDialogCaption(_SafeStr_819.getLocalization("inventory.remove.external_image_wallitem_delete"), "", true));
                    return;
                case "makeOwnButton":
                    if (getType() == "photo_poster")
                    {
                        _local_4 = new HabboToolbarEvent("HTE_ICON_CAMERA");
                        _local_4.iconName = "imageWidgetMakeOwn";
                        ownHandler.container.toolbar.events.dispatchEvent(_local_4);
                        hide();
                    }
                    else
                    {
                        if (_SafeStr_659.getInteger("spaweb", 0) == 1)
                        {
                            HabboWebTools.openPage("/stories/cards/selfie/edit");
                        }
                        else
                        {
                            _SafeStr_659.context.createLinkEvent("games/play/elisa_habbo_stories?ref=btn_selfie_myo");
                        };
                    };
                    return;
                case "shareButton":
                    _shareArea.visible = true;
                    HabboTracking.getInstance().trackEventLog("Stories", "shareopened", "stories.share.clicked", _SafeStr_4098);
                    return;
                case "twitterShare":
                    (navigateToURL(new URLRequest(("http://www.twitter.com/share?url=" + _SafeStr_4097)), "_blank"));
                    HabboTracking.getInstance().trackEventLog("Stories", "twitter", "stories.share.clicked", _SafeStr_4098);
                    return;
                case "fbShare":
                    (navigateToURL(new URLRequest(("https://www.facebook.com/sharer/sharer.php?u=" + _SafeStr_4097)), "_blank"));
                    HabboTracking.getInstance().trackEventLog("Stories", "facebook", "stories.share.clicked", _SafeStr_4098);
                    return;
                case "senderNameButton":
                    ownHandler.sendMessage(new GetExtendedProfileMessageComposer(_SafeStr_1721));
                    return;
                case "urlField":
                    _local_5 = (_window.findChildByName("urlField") as ITextFieldWindow);
                    _local_5.setSelection(0, _local_5.length);
                    HabboTracking.getInstance().trackEventLog("Stories", "fieldselected", "stories.share.clicked", _SafeStr_4098);
                    return;
                case "reportButton":
                    openReportImage();
                    return;
                case "nextButton":
                    showNext();
                    return;
                case "previousButton":
                    showPrevious();
                    return;
            };
        }

        private function onClickModerationInfoLink(_arg_1:WindowLinkEvent):void
        {
            if (((!(_arg_1 == null)) && (!(StringUtil.isBlank(_arg_1.link)))))
            {
                (navigateToURL(new URLRequest(_arg_1.link), "_blank"));
            };
        }

        private function openReportImage():void
        {
            _habboHelp.startPhotoReportingInNewCfhFlow(_SafeStr_1721, _SafeStr_4091.caption, _SafeStr_4096, _SafeStr_4095);
        }

        private function getType():String
        {
            switch (_SafeStr_4098)
            {
                case "external_image_wallitem_poster":
                case "external_image_wallitem_poster_small":
                    return ("photo_poster");
                case "external_image_wallitem":
                    return ("selfie");
            };
            return ("legacy");
        }

        private function onReportWindowEvent(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            var _local_3:int;
            var _local_9:IWindow;
            var _local_8:ISelectableWindow;
            var _local_6:String;
            var _local_4:IWindow;
            var _local_7:IIlluminaInputWidget;
            var _local_5:Boolean;
            if (_arg_1.type != "WME_CLICK")
            {
                return;
            };
            switch (_arg_2.name)
            {
                case "header_button_close":
                    reportWindow.destroy();
                    return;
                case "report_confirm":
                    _local_3 = 0;
                    _local_9 = reportWindow.findChildByName("reporting_reason");
                    if (_local_9 != null)
                    {
                        _local_8 = ISelectorWindow(_local_9).getSelected();
                        if (_local_8 != null)
                        {
                            _local_3 = int(_local_8.name);
                        };
                    };
                    _local_6 = null;
                    _local_4 = reportWindow.findChildByName("input_widget");
                    if (_local_4 != null)
                    {
                        _local_7 = ((_local_4 as IWidgetWindow).widget as IIlluminaInputWidget);
                        _local_6 = _local_7.message;
                    };
                    if (!_SafeStr_4097)
                    {
                        _SafeStr_4097 = "url not available";
                    };
                    if (getType() == "photo_poster")
                    {
                        _local_5 = _habboHelp.reportPhoto(_SafeStr_4096, _local_3, _roomEngine.activeRoomId, _SafeStr_1721, _SafeStr_4095);
                    }
                    else
                    {
                        _local_5 = _habboHelp.reportSelfie(_SafeStr_4097, _local_6, _roomEngine.activeRoomId, _SafeStr_1721, _SafeStr_4095);
                    };
                    if (_local_5)
                    {
                        reportWindow.destroy();
                    };
                    return;
            };
        }

        private function onDeleteConfirm(_arg_1:_SafeStr_126, _arg_2:WindowEvent):void
        {
            _arg_1.dispose();
            if (_arg_2.type == "WE_OK")
            {
                ownHandler.deleteCard(_SafeStr_4095);
            };
        }


    }
}