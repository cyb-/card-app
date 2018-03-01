angular.module("cardApp").factory("Flash", [function()
{
  function Flash(datas)
  {
    this.type = datas.type;
    this.message = datas.msg;
    this.timeout = datas.timeout;
  }

  Flash.prototype.toString = function()
  {
    return this.message;
  }

  Flash.prototype.getCssClass = function()
  {
    return "alert alert-" + (this.type || "info");
  }

  Flash.prototype.getTimeout = function()
  {
    return (this.timeout || null);
  }

  Flash.build = function(datas)
  {
    return new Flash(datas);
  }

  return Flash;
}]);
