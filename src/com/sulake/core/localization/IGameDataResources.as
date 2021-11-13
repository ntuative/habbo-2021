package com.sulake.core.localization
{
    public /*dynamic*/ interface IGameDataResources 
    {

        function isValid():Boolean;
        function getExternalTextsUrl():String;
        function getExternalTextsHash():String;
        function getExternalVariablesUrl():String;
        function getExternalVariablesHash():String;
        function getFurniDataUrl():String;
        function getFurniDataHash():String;
        function getProductDataUrl():String;
        function getProductDataHash():String;

    }
}