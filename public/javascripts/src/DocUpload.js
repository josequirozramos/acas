(function() {
  var extend = function(child, parent) { for (var key in parent) { if (hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
    hasProp = {}.hasOwnProperty,
    bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  window.DocUpload = (function(superClass) {
    extend(DocUpload, superClass);

    function DocUpload() {
      return DocUpload.__super__.constructor.apply(this, arguments);
    }

    DocUpload.prototype.defaults = {
      url: "",
      currentFileName: "",
      description: "",
      docType: "",
      documentKind: "experiment"
    };

    DocUpload.prototype.validate = function(attrs) {
      var errors, ref;
      errors = [];
      if ((ref = attrs.docType) !== 'url' && ref !== 'file') {
        errors.push({
          attribute: 'docType',
          message: "Type must be one of url or file"
        });
      }
      if (attrs.docType === 'file') {
        if (attrs.currentFileName === "") {
          errors.push({
            attribute: 'currentFileName',
            message: "must set file when docType is file"
          });
        }
      }
      if (attrs.docType === 'url') {
        if (attrs.url === "") {
          errors.push({
            attribute: 'url',
            message: "must set url when docType is url"
          });
        }
      }
      if (errors.length > 0) {
        return errors;
      } else {
        return null;
      }
    };

    return DocUpload;

  })(Backbone.Model);

  window.DocUploadController = (function(superClass) {
    extend(DocUploadController, superClass);

    function DocUploadController() {
      this.updateModel = bind(this.updateModel, this);
      this.attributeChanged = bind(this.attributeChanged, this);
      this.clearNewFileName = bind(this.clearNewFileName, this);
      this.setNewFileName = bind(this.setNewFileName, this);
      this.docTypeChanged = bind(this.docTypeChanged, this);
      this.render = bind(this.render, this);
      return DocUploadController.__super__.constructor.apply(this, arguments);
    }

    DocUploadController.prototype.template = _.template($("#DocUploadView").html());

    DocUploadController.prototype.events = {
      'change [name="docTypeRadio"]': "docTypeChanged",
      'change .bv_url': "attributeChanged",
      'change .bv_description': "attributeChanged"
    };

    DocUploadController.prototype.initialize = function() {
      this.errorOwnerName = 'DocUploadController';
      $(this.el).html(this.template());
      this.fileInputController = new LSFileInputController({
        el: this.$('.bv_fileInput'),
        inputTitle: '',
        url: UtilityFunctions.prototype.getFileServiceURL(),
        fieldIsRequired: false,
        requiresValidation: false,
        maxNumberOfFiles: 1
      });
      this.fileInputController.on('fileInput:uploadComplete', this.setNewFileName);
      this.fileInputController.on('fileInput:removedFile', this.clearNewFileName);
      this.setBindings();
      if (!this.model.isNew()) {
        this.$('.bv_fileInput').hide();
        if (this.model.get('docType') === 'file') {
          $('.bv_currentFileRadio').attr('checked', true);
          return this.$('.bv_currentFileName').html(this.model.get('currentFileName'));
        } else {
          this.$('.bv_currentDocContainer').hide();
          $('.bv_urlRadio').attr('checked', true);
          return this.$('.bv_url').val(this.model.get('url'));
        }
      }
    };

    DocUploadController.prototype.render = function() {
      this.fileInputController.render();
      if (this.model.isNew()) {
        this.$('.bv_currentDocContainer').hide();
      }
      if (!this.$('.bv_urlRadio').is(":checked")) {
        this.$('.bv_urlInputWrapper').hide();
      }
      return this;
    };

    DocUploadController.prototype.docTypeChanged = function(event) {
      var currentChecked;
      currentChecked = this.$('[name="docTypeRadio"]:checked').val();
      if (currentChecked !== 'url') {
        this.$('.bv_urlInputWrapper').hide('slide');
      } else {
        this.$('.bv_urlInputWrapper').show('slide');
      }
      if (currentChecked !== 'file') {
        this.$('.bv_fileInput').hide('slide');
      } else {
        this.$('.bv_fileInput').show('slide');
      }
      return this.updateModel();
    };

    DocUploadController.prototype.setNewFileName = function(fileNameOnServer) {
      this.model.set({
        currentFileName: fileNameOnServer
      });
      return this.updateModel();
    };

    DocUploadController.prototype.clearNewFileName = function() {
      this.model.set({
        currentFileName: ""
      });
      return this.updateModel();
    };

    DocUploadController.prototype.attributeChanged = function() {
      this.trigger('amDirty');
      return this.updateModel();
    };

    DocUploadController.prototype.updateModel = function() {
      return this.model.set({
        docType: this.$('[name="docTypeRadio"]:checked').val(),
        url: this.$('.bv_url').val(),
        description: this.$('.bv_description').val()
      });
    };

    return DocUploadController;

  })(AbstractFormController);

}).call(this);