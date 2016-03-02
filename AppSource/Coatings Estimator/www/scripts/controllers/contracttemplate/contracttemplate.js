/**
 * @ngdoc function
 * @name estimateApp.controller:ContractTemplateLayoutCtrl
 * @description
 * # ContractTemplateLayoutCtrl
 * Controller of the estimateApp
 */
angular.module('estimateApp')
    .controller('ContractTemplateCtrl', [
        '$rootScope', '$state', '$scope', '$stateParams', 'ContractTemplate', 'Storage', '$q', 'Reference', 'Log', '$window','Config', '$cordovaCamera',function (
            $rootScope, $state, $scope, $stateParams, Service, Storage, $q, Reference, Log,$window, Config, $cordovaCamera) {
            'use strict';
            $scope.saving = false;

            function init() {

                $scope.Model = {
                    name: '',
                    type: '',
                    layout: '',
                    header: {id: 0, data: ''},
                    term: {id: 0, data: ''},
                    footer: {id: 0, data: ''}
                };

                $scope.HeaderModelPrime = {id: 0, data: ''};
                $scope.FooterModelPrime = {id: 0, data: ''};
                $scope.TermModelPrime = {id: 0, data: ''};

                $scope.cameraOptions = {};
                $scope.cameraOptionsFromLibrary = {};

                if (navigator && navigator.camera) {
                  $scope.cameraOptions = {
                    quality: 50,
                    destinationType: Camera.DestinationType.DATA_URL,
                    encodingType: Camera.EncodingType.PNG,
                    correctOrientation: true,
                    targetWidth: 800,
                    targetHeight: 600
                  };
                  $scope.cameraOptionsFromLibrary = {
                    quality: 40,
                    correctOrientation: true,
                    destinationType: Camera.DestinationType.DATA_URL,
                    //destinationType: Camera.DestinationType.FILE_URI,
                    encodingType: Camera.EncodingType.PNG,
                    sourceType: Camera.PictureSourceType.PHOTOLIBRARY
                  };

                }

                $scope.Layouts = [];

                function get(id) {

                    var promises = [];
                    var headerhints = {
                        populate: true,
                        searchType: 'use',
                        storageType: 'contracttemplateheader'
                    };
                    var termhints = {
                        populate: true,
                        searchType: 'use',
                        storageType: 'contracttemplateterm'
                    };
                    var footerhints = {
                        populate: true,
                        searchType: 'use',
                        storageType: 'contracttemplatefooter'
                    };
                    var criteria = [];
                    criteria.push({fid: id});

                    // get contracttemplate
                    promises.push(Service.Get(id));

                    // get contracttemplateheader
                    //promises.push(Storage.Search(criteria, headerhints));

                    // get contracttemplatefooter
                    //promises.push(Storage.Search(criteria, footerhints));

                    // get contracttemplateterm
                    //promises.push(Storage.Search(criteria, termhints));

                    $q.all(promises)
                        .then(function (promiseResults) {
                          var ret = promiseResults[0][0];
                        $scope.Model = ret;
                          $scope.Model.header = $scope.Model.headerImgSize == 0 ? {id:0, data: ""} : {id:0, data:Config.WebStorageEndpoint + ret.headerid + ".png"};
                          $scope.Model.footer = $scope.Model.footerImgSize == 0 ? {id:0, data: ""} : {id:0, data:Config.WebStorageEndpoint + ret.footerid + ".png"};
                          $scope.Model.term = {id:0, data:ret.term};

                        window.setHeader = function() {
                          $scope.Model.header = {id:0, data:'data:image/png;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wBDABQODxIPDRQSEBIXFRQYHjIhHhwcHj0sLiQySUBMS0dARkVQWnNiUFVtVkVGZIhlbXd7gYKBTmCNl4x9lnN+gXz/2wBDARUXFx4aHjshITt8U0ZTfHx8fHx8fHx8fHx8fHx8fHx8fHx8fHx8fHx8fHx8fHx8fHx8fHx8fHx8fHx8fHx8fHz/wAARCACQAJADASIAAhEBAxEB/8QAHwAAAQUBAQEBAQEAAAAAAAAAAAECAwQFBgcICQoL/8QAtRAAAgEDAwIEAwUFBAQAAAF9AQIDAAQRBRIhMUEGE1FhByJxFDKBkaEII0KxwRVS0fAkM2JyggkKFhcYGRolJicoKSo0NTY3ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqDhIWGh4iJipKTlJWWl5iZmqKjpKWmp6ipqrKztLW2t7i5usLDxMXGx8jJytLT1NXW19jZ2uHi4+Tl5ufo6erx8vP09fb3+Pn6/8QAHwEAAwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoL/8QAtREAAgECBAQDBAcFBAQAAQJ3AAECAxEEBSExBhJBUQdhcRMiMoEIFEKRobHBCSMzUvAVYnLRChYkNOEl8RcYGRomJygpKjU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6goOEhYaHiImKkpOUlZaXmJmaoqOkpaanqKmqsrO0tba3uLm6wsPExcbHyMnK0tPU1dbX2Nna4uPk5ebn6Onq8vP09fb3+Pn6/9oADAMBAAIRAxEAPwDmKKKKAFAzRt9KSrmnWxvLuK33bPMON2M4pDKpU0qoW4UFj7Cuum0fTtLhEs6STnoOM5P0FUpNTlxtsrGOFfVzj9BSclHdlKEpfCjESwun+7A+PcYqzDod7MeFRfq1TST6hJ965VPZE/xqBhcfxXk5+jYqPbQ7l+wqdi6nhO+YZMkA/E/4UP4TvVGfNgP4n/Csx0c9Zpj9ZDURDr0llH/AzTVSLB0ZIuzaFeRHkI30aq7aZeJ1gY/Tmq5nuU+7czf99mpI9X1CE8XBb/eANUpJkOEkRvG8ZxIjKfcYplasPieYDbdW0Uy98cVcjn0DUsLJG1pIe/QZ/DiqJs0c9RWjrWmDS7lI1lMiuu4EjBHNZ1AgooooAKKKKAFzWn4fP/E3tf8Af/pWWK0tBP8AxOrT/f8A6GgZ0WvTMJUTPy88VkbqveJGxcx/Q1k+btXJrgqq8melQdoImcgDnv0FRlSeTx7Ux5hBGZZOWPAH9KhE1y0BnzGExnbg5qFFmjkiZgR04qJmf1z9akhlW4j3AYPQj0qOchFJPaqW9iXtdFeQqeq8+oqrIp/Chp2J4AApVbeD6966UnE5W1IgNW9KAbUoAwBBbkGoHWrGkjGp2/8Av1qmYtWN7xj/AMf1v/1y/qa56uh8Y/8AH9b/APXL+prnqoyCiiigAooooAK0dA/5DVp/v/0NZ1aOgf8AIatP9/8AoaANbxOcXcf0P9KxVbdIPRefxrW8Vti8j+h/pWHE3LH3rmmtWdtJ+6iad9jRSkEqjZIFSh96faBkR4ztpisCMHkULDF6HHpk4rHSx0Ju+hLbje8su0qrEYB9hUN5GXibH1q2rYFNIyKhStK5pypxsZRACjCLx9eabEu6R2ChVxjA6VoPAhPK0woAMAYFdCmrGEqbuUnXFT6Wv/Ezt/8AfpJV+Q1Npq/8TGD/AHquLMJx3NXxj/x/W/8A1y/qa56uh8Y/8f1v/wBcv6muerc5AooooAKKKKACtHQP+Q1af7/9DWdVvSZxb6nbSt91ZBn6HigDU8XnF7F9D/SsKNuT9a6jxjaF4UuFGdh5rkUbms5I3py0LnmBVyTxSrO+8Dym5GR6mq2WZ4woBOeAe9am6TzVyo6VzysjrppyGpIGXIp4cAZJwBVZWfzpQ4AOeg6Uy5ciHjpnmo5Luxop2VySS8UHhCR65p0ciTqSnbqD2qo5yF+WPkf3qdZg/bHAAA28hTkVfIraE875ku5LOv7s+/FTacv/ABMIP96kkXdIF7Lyf6VpaDaGa/DkfLHzRB3aQqismxPGP/H9b/8AXL+prnq3PFs4l1URr/yyjCn6nmsOuw8wKKKKACiiigAooooA7TTbpNX0jy5TmRBsk+vY1xuoWb2F28TDAB4+lWdMv3067Ey5KHiRfUf410ep2cOr2ayRMCxGY39fY0ik7HGg7h/niphLK0gczNkDAqCWOS3maORSjqcEGnI6n73B9RWbRvGRZjIUYH1Oe9P4dSrcg1CgB6Ov48VKBjq6/nWTN4kX2LJ4fj3FW4I1t12x/M7dSaYGHY5qRD6VMpNqzNIRindFiKIthV5Zjz7mujtxFpGnPNL/AAjc3ufSqulWXlKJphhj0B7Vja/qv26YQQt/o8R6/wB9vX6VrSp21ZzYispe7HYzJ5nuJ5JpDl5GLGo6KK3OQKKKKACiiigAooooAK0NK1NrB9j5a3Y8j+6fUVn0UAdPqNjBqUIdSN2MpIv+elcrc201pKUmXB7HsfpV6w1CSxbby8JPKenuK6S3jtNVtsOFlibv3B/oaBp2OLVqlVq0tV8N3NiDLBmaDrkDlfqP61W0zSrrUW/cptjH3pG6Cs3E2jMZHlmCqCzHoB3roNM04Q4lnwZOw7LUsenW+mx5BywHzSN/nisfUdXa4BhtSVi6M/dvp7U4wS1YpVW9EWNZ1jzA1paN8nSSQd/YVidKAMDAoqzEKKKKACiiigAooooAKKKkggluZBHBG0jnoqjJoAjorQ/sTU/+fKb/AL5pkWkahNGHjs5mU9Dt60AUqns7yewm823bB/iU9G+tOubC7swDc28kQboWHBpPsN19m+0+RJ5B437eKAO20bWrbUk2A+XOB80THn8PUVPqN7aaZb7pmWMfwoo5Y+wril0XVAyulnOrDlWUYIoudN1WR2mu4LiRwMl3GcCgBmpanNqUh3Dy4QfljB/nVKpbi2mtZPLuInifGcMMHFSLp925iCW8jeaN0eFzuHrQBWorQ/sPU/8Anxm/75qOHSb+dN8VpK69MhaAKdFWLqxurMKbqB4t33dwxmq9ABRRRQAUUUUAFbvh1njtNVkiJEqW+UYdR16VnaVp7alerbq4jBBYsRnAFa9kmnadOZbbX1R8YP7rII9xQBkxajqbMmb26wSM/Oa1PE17fQ6w0VvcTxRCNdqoxA6VqveTQQxyXmsW8QmBaPFtnK9jUMWqQxxqn/CRQvtGMvb5NAFWwW71Tw/cwzSySyNcIqNIckcjNbfkE3RtftFv9g+z+QIt/wA+71x61Vu7l7V4muNcijLJvjX7PwwPfrWanhSQ3Eskd5umQLIrMuCzHn1oAfpE99HLq0NzczO8ED43MTgjuKPC11cXUN4bmeSYhUxvbOOaz7e51S81a4iQItxcr5MvyYwBwSasfY73RdSTTrGdJGulU7mTsCaANDUXg1m+u9Mn2x3ULf6NJ/e4B2mrjJNZ+HzgGO5hsyAR1U+1Y2oaUq3631xqa+XK5DzqmNkijpgfStF5CFh1FtfURAGJW8j5W9QR36UAUtJ26gIYX1rUFupFyUBOAfrilGrWk8EUE1xf2ckA8vfCflbHGTitCW8ltQj3OtW0SyjdERbfeX161FFc3EtuRpmq29z5ON6/Z8ELnr1oAw9ctJEgtrr+0ZL23kJEZkzkHvwayK6rWoLa4uVh1PXVV4ekYgwBn6Viatpw06aIJMJopo/MRwMZFAFCiiigAooooA2fCs0cOsqZHVAyMoLHAzW5t1TJxBo1cVTdi+lAHY2cOtwQLGbjT5oh0SU5AHpWf4mitora1YxW0V47HzEtzldvrXPbF9KUIoOQKANrxMytPp20g4tFBwelbutXXk6ZdyQShZFWEqQecg1xGBnOOaCik5IoA6W+1+2Gnm4tIwmpXa+XKR/AB1P4/wCelabvb2TRarcMGWCzSNVUjcWPXH+e9cRSFVJyRQB1Nrc6bqdjd6bawywNIDMpmbILj3zWfdsv/CI2iZG4XRyuee9Y9JtHHHSgDp7zTzrVrp81pPbgQwCN1d8EGpdLsv7DiuZLy4t/3yrGgR8knNcmVB6ik2L6UAdXq+q6dFrMsc2lxXGCu+bdyRgVS8VAyXNrNCYzZ+UFh2dvY1hAAdB1owM5xzQAtFFFAH//2Q=='};
                        };

                        window.setFooter = function() {
                          $scope.Model.footer = {id:0, data:'data:image/png;base64,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'};
                        }


                          //$scope.Model.header = {id:0, data:'data:image/png;base64,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'}
                          //$scope.Model.footer = {id:0, data:'data:image/png;base64,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'}
                        //$scope.Model.term = {id:0, data:'This is term.'};
                        }, function (error) {
                            Reference.ProcessError(error, $scope.errors);
                        });
                }

                if ($stateParams.id) {
                    get($stateParams.id);
                }

                function populateContractTemplate(model) {
                    if (model) {
                        $scope.Model = model;

                        $scope.Model.header = {id: 0, data: ''};
                        $scope.Model.term = {id: 0, data: ''};
                        $scope.Model.footer = {id: 0, data: ''};
                    }
                }

                function populateHeader(model) {
                    if (model) {
                        $scope.Model.header = model;
                        $scope.HeaderModelPrime = angular.copy(model);
                    }
                }

                function populateFooter(model) {
                    if (model) {
                        $scope.Model.footer = model;
                        $scope.FooterModelPrime = angular.copy(model);
                    }
                }

                function populateTerm(model) {
                    model = {data:"This is term."};

                    if (model) {
                        $scope.Model.term = model;
                        $scope.TermModelPrime = angular.copy(model);
                    }
                }

                function getLayouts() {
                    var criteria = {},
                        hints = {};
                    hints.storageType = 'contracttemplatelayout';
                    hints.searchType = 'use';
                    Storage.Search(criteria, hints)
                        .then(function (layout) {
                            $scope.Layouts = layout;
                        }, function (error) {

                        });
                }

                getLayouts();

                $scope.Cancel = function () {
                    $rootScope.back();
                };

                $scope.Save = function (model) {
                    var errors = [];
                    model.errors = [];
                    validate(model, errors);

                    if (errors.length > 0) {
                        model.errors = errors;
                        model.error = errors.join(', ');
                        return model.error;
                    }

                    model.error = [];
                    model.errors = [];

                    var saves = [];

                    if ($stateParams.id && ($stateParams.id).length > 10) {

                        Service.Update(model)
                            .then(function () {
                                //saves.push(processStorage(model.id, saves, $scope.HeaderModelPrime, $scope.Model.header, 'contracttemplateheader'));
                                //saves.push(processStorage(model.id, saves, $scope.FooterModelPrime, $scope.Model.footer, 'contracttemplatefooter'));
                                //saves.push(processStorage(model.id, saves, $scope.TermModelPrime, $scope.Model.term, 'contracttemplateterm'));
                            },
                            function (error) {
                                model.errors = error;
                                model.error = model.errors.join(', ');
                                return;
                            }
                        );
                    }
                    else {
                        Service.Add(model)
                            .then(function () {
                                //saves.push(processStorage(model.id, saves, $scope.HeaderModelPrime, $scope.Model.header, 'contracttemplateheader'));
                                //saves.push(processStorage(model.id, saves, $scope.FooterModelPrime, $scope.Model.footer, 'contracttemplatefooter'));
                                //saves.push(processStorage(model.id, saves, $scope.TermModelPrime, $scope.Model.term, 'contracttemplateterm'));
                            },
                            function (error) {
                                model.errors = error;
                                model.error = model.errors.join(', ');
                                return;
                            }
                        );
                    }

                    $q.all(saves)
                        .then(function (promiseResults) {
                            $rootScope.back();
                        }, function (error) {
                            Reference.ProcessError(error, $scope.errors);
                        });

                };

                function validate(model, errors) {
                    if (model.name === '')      errors.push('missing name');
                    if (model.type === '')      errors.push('missing print layout');
                    if (model.layoutid === '')  errors.push('missing contract format');
                }

                function processStorage(fid, promises, prime, model, type) {

                    // if the prime data and the model data are the same then return
                    if (prime.data === model.data) {
                        return;
                    }

                    // no original data
                    if (prime.id === 0) {
                        // add
                        if (model.data !== '') {
                            model.type = type;
                            model.fid = fid;
                            promises.push(Storage.Add(model));
                        }
                    } else {
                        // update
                        if (prime.data !== model.data && model.data !== '') {
                            promises.push(Storage.Update(model));
                        }
                        // delete
                        if (prime.data !== model.data && model.data === '') {
                            promises.push(Storage.Remove(prime.id));
                        }
                    }
                }


                function fileTooLargeCallback(buttonIndex){

                }

                function fileTooLarge(fileLength) {

                    Log.Log('file too large ' + fileLength);
                    var prompt = 'The image that you chose is too large, please select an images that is less than 100KB in size.';

                    if(navigator && navigator.notification){
                        navigator.notification.alert(
                            prompt,
                            fileTooLargeCallback,
                            'File Too Large',
                            'Ok'
                        );
                    }
                    else{
                        var confirmDeleteSystem = $window.alert(prompt);
                    }


                }

                $scope.GetImage = function (model, mode) {
                    $scope.errors = [];

                    var option = (mode == 0) ? $scope.cameraOptions : $scope.cameraOptionsFromLibrary;



                    if ($cordovaCamera.getPicture) {
                        $cordovaCamera.getPicture(option)
                            .then(function (imageData) {
                                //140000 max length
                                Log.Log('imageData length ' + imageData.length);

                                if (imageData.length > 150000) {
                                    fileTooLarge(imageData.length);
                                } else{
                                    model.data = "data:image/png;base64," + imageData;
                                }

                            }, function (error) {
                                Reference.ProcessError(error, $scope.errors);
                            });
                    }
                    else {

                    }
                };

                $scope.RemoveImage = function (model, property) {
                    property.id = 0;
                    property.data = '';
                };

            }

            init();

            $rootScope.$on(Config.AjaxActivity, function (event, data) {
                $scope.saving = data;
            });
        }]);
