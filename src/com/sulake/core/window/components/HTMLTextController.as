package com.sulake.core.window.components
{
    import flash.text.StyleSheet;
    import com.sulake.core.window.WindowContext;
    import flash.geom.Rectangle;
    import com.sulake.core.window.IWindow;
    import flash.net.URLRequest;
    import flash.external.ExternalInterface;
    import flash.net.navigateToURL;
    import com.sulake.core.window.theme._SafeStr_173;
    import com.sulake.core.window.events.WindowLinkEvent;
    import flash.events.TextEvent;
    import com.sulake.core.runtime.events.ILinkEventTracker;
    import flash.events.Event;
    import com.sulake.core.window.utils.PropertyStruct;

    public class HTMLTextController extends TextFieldController implements IHTMLTextWindow
    {

        private static const HTML_STYLESHEET_KEY:String = "html_stylesheet";

        private static var _defaultLinkTarget:String = "default";

        private var _SafeStr_910:String = "default";
        private var _htmlStyleSheetString:String = null;
        private var _SafeStr_911:StyleSheet = null;

        public function HTMLTextController(_arg_1:String, _arg_2:uint, _arg_3:uint, _arg_4:uint, _arg_5:WindowContext, _arg_6:Rectangle, _arg_7:IWindow, _arg_8:Function, _arg_9:Array=null, _arg_10:Array=null, _arg_11:uint=0)
        {
            super(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5, _arg_6, _arg_7, _arg_8, _arg_9, _arg_10, _arg_11);
            immediateClickMode = true;
            _field.type = "dynamic";
            _field.mouseEnabled = true;
            _field.selectable = false;
            _field.mouseWheelEnabled = true;
        }

        public static function set defaultLinkTarget(_arg_1:String):void
        {
            _defaultLinkTarget = _arg_1;
        }

        public static function get defaultLinkTarget():String
        {
            return (_defaultLinkTarget);
        }

        private static function setHtmlStyleSheetString(_arg_1:HTMLTextController, _arg_2:String):void
        {
            var _local_3:StyleSheet;
            if (_arg_1 == null)
            {
                return;
            };
            if (_arg_1._htmlStyleSheetString == _arg_2)
            {
                return;
            };
            _arg_1._htmlStyleSheetString = _arg_2;
            _arg_1._SafeStr_911 = null;
            if (_arg_1._htmlStyleSheetString != null)
            {
                _local_3 = new StyleSheet();
                _local_3.parseCSS(_arg_1._htmlStyleSheetString);
                _arg_1._SafeStr_911 = _local_3;
            };
        }

        private static function convertLinksToEvents(_arg_1:String):String
        {
            var _local_2:RegExp;
            _local_2 = /<a[^>]+(http:\/\/[^"']+)['"][^>]*>(.*)<\/a>/gi;
            _arg_1 = _arg_1.replace(_local_2, "<a href='event:$1'>$2</a>");
            _local_2 = /<a[^>]+(https:\/\/[^"']+)['"][^>]*>(.*)<\/a>/gi;
            return (_arg_1.replace(_local_2, "<a href='event:$1'>$2</a>"));
        }

        private static function openWebPage(_arg_1:String, _arg_2:String):void
        {
            var _local_5:String;
            var _local_3:*;
            var _local_4:URLRequest;
            if (_arg_2 == null)
            {
                _arg_2 = _defaultLinkTarget;
            };
            if (ExternalInterface.available)
            {
                try
                {
                    _local_5 = ExternalInterface.call("function() { return navigator.userAgent; }").toLowerCase();
                }
                catch(e:Error)
                {
                    _local_5 = "";
                };
                if (((((_local_5.indexOf("safari") > -1) || (_local_5.indexOf("chrome") > -1)) || (_local_5.indexOf("firefox") > -1)) || ((_local_5.indexOf("msie") > -1) && (Number(_local_5.substr((_local_5.indexOf("msie") + 5), 3)) >= 7))))
                {
                    try
                    {
                        _local_3 = ExternalInterface.call((((("function() {var win = window.open('" + _arg_1) + "', '") + _arg_2) + "'); if (win) { win.focus();} return true; }"));
                    }
                    catch(e:Error)
                    {
                    };
                    if (_local_3)
                    {
                        return;
                    };
                };
                _local_4 = new URLRequest(_arg_1);
                (navigateToURL(_local_4, _arg_2));
            };
        }


        public function set linkTarget(_arg_1:String):void
        {
            if (_SafeStr_173.HTML_LINK_TARGET_RANGE.indexOf(_arg_1) > -1)
            {
                _SafeStr_910 = _arg_1;
            };
        }

        public function get linkTarget():String
        {
            return ((_SafeStr_910 == "default") ? defaultLinkTarget : _SafeStr_910);
        }

        public function get htmlStyleSheetString():String
        {
            return (_htmlStyleSheetString);
        }

        public function set htmlStyleSheetString(_arg_1:String):void
        {
            setHtmlStyleSheetString(this, _arg_1);
        }

        override public function set immediateClickMode(_arg_1:Boolean):void
        {
            if (((_arg_1 == _SafeStr_912) || (_field == null)))
            {
                return;
            };
            super.immediateClickMode = _arg_1;
            if (_SafeStr_912)
            {
                _field.addEventListener("link", immediateClickHandler);
            }
            else
            {
                _field.removeEventListener("link", immediateClickHandler);
            };
        }

        override public function set text(_arg_1:String):void
        {
            if (_arg_1 == null)
            {
                return;
            };
            if (_localized)
            {
                context.removeLocalizationListener(_caption.slice(2, _caption.indexOf("}")), this);
                _localized = false;
            };
            _caption = _arg_1;
            if (((_caption.charAt(0) == "$") && (_caption.charAt(1) == "{")))
            {
                context.registerLocalizationListener(_caption.slice(2, _caption.indexOf("}")), this);
                _localized = true;
            }
            else
            {
                if (_field != null)
                {
                    _field.htmlText = convertLinksToEvents(_caption);
                    refreshTextImage();
                };
            };
        }

        override public function set localization(_arg_1:String):void
        {
            if (((!(_arg_1 == null)) && (!(_field == null))))
            {
                _field.htmlText = limitStringLength(convertLinksToEvents(_arg_1));
                refreshTextImage();
            };
        }

        override public function set htmlText(_arg_1:String):void
        {
            if (_arg_1 == null)
            {
                return;
            };
            if (_localized)
            {
                context.removeLocalizationListener(_caption.slice(2, _caption.indexOf("}")), this);
                _localized = false;
            };
            _caption = _arg_1;
            if (((_caption.charAt(0) == "$") && (_caption.charAt(1) == "{")))
            {
                context.registerLocalizationListener(_caption.slice(2, _caption.indexOf("}")), this);
                _localized = true;
            }
            else
            {
                if (_field != null)
                {
                    _field.htmlText = convertLinksToEvents(_caption);
                    _field.styleSheet = _SafeStr_911;
                    refreshTextImage();
                };
            };
        }

        override protected function immediateClickHandler(_arg_1:Event):void
        {
            var _local_4:WindowLinkEvent;
            var _local_2:Boolean;
            if ((_arg_1 is TextEvent))
            {
                _local_4 = (WindowLinkEvent.allocate(TextEvent(_arg_1).text, this, null) as WindowLinkEvent);
                if (_SafeStr_913)
                {
                    _SafeStr_913.dispatchEvent(_local_4);
                };
                _local_2 = false;
                for each (var _local_3:ILinkEventTracker in _context.linkEventTrackers)
                {
                    if (_local_3.linkPattern.length > 0)
                    {
                        if (_local_4.link.substr(0, _local_3.linkPattern.length) == _local_3.linkPattern)
                        {
                            _local_3.linkReceived(_local_4.link);
                            _local_2 = true;
                        };
                    }
                    else
                    {
                        _local_3.linkReceived(_local_4.link);
                    };
                };
                if (!_local_4.isWindowOperationPrevented())
                {
                    if (procedure != null)
                    {
                        procedure(_local_4, this);
                    };
                };
                if ((((!(_local_2)) && (!(_local_4.isWindowOperationPrevented()))) && (!(linkTarget == "internal"))))
                {
                    openWebPage(TextEvent(_arg_1).text, linkTarget);
                };
                _arg_1.stopImmediatePropagation();
                _local_4.recycle();
            }
            else
            {
                super.immediateClickHandler(_arg_1);
            };
        }

        override public function get properties():Array
        {
            var _local_1:Array = InteractiveController.writeInteractiveWindowProperties(this, super.properties);
            _local_1.push(createProperty("editable", (_field.type == "input")));
            _local_1.push(createProperty("focus_capturer", _SafeStr_914));
            _local_1.push(createProperty("selectable", _field.selectable));
            _local_1.push(createProperty("display_as_password", _field.displayAsPassword));
            _local_1.push(createProperty("display_raw", _SafeStr_905));
            _local_1.push(createProperty("link_target", _SafeStr_910));
            return (_local_1);
        }

        override public function set properties(_arg_1:Array):void
        {
            for each (var _local_2:PropertyStruct in _arg_1)
            {
                switch (_local_2.key)
                {
                    case "link_target":
                        _SafeStr_910 = (_local_2.value as String);
                        break;
                    case "html_stylesheet":
                        htmlStyleSheetString = (_local_2.value as String);
                };
            };
            super.properties = _arg_1;
        }


    }
}