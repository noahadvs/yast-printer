# encoding: utf-8

# ------------------------------------------------------------------------------
# Copyright (c) 2006 Novell, Inc. All Rights Reserved.
#
#
# This program is free software; you can redistribute it and/or modify it under
# the terms of version 2 of the GNU General Public License as published by the
# Free Software Foundation.
#
# This program is distributed in the hope that it will be useful, but WITHOUT
# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
# FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License along with
# this program; if not, contact Novell, Inc.
#
# To contact Novell about this file by physical or electronic mail, you may find
# current contact information at www.novell.com.
# ------------------------------------------------------------------------------

# File:        include/printer/driveradd.ycp
# Package:     Configuration of printer
# Summary:     Add Driver dialog definition
# Authors:     Johannes Meixner <jsmeix@suse.de>
#
# $Id: driveradd.ycp 27914 2006-02-13 14:32:08Z locilka $
module Yast
  module PrinterDriveraddInclude
    def initialize_printer_driveradd(include_target)
      Yast.import "UI"

      textdomain "printer"

      Yast.import "Label"
      Yast.import "Wizard"
      Yast.import "Printerlib"
      Yast.import "Printer"
      Yast.import "Popup"

      Yast.include include_target, "printer/helps.rb"
    end

    # AddDriver dialog
    # @return dialog result
    def AddDriverDialog
      caption = _("Driver Packages")
      _OpenPrintingPPDs_ghostscript_installed = Printerlib.TestAndInstallPackage(
        "OpenPrintingPPDs-ghostscript",
        "installed"
      )
      _OpenPrintingPPDs_hpijs_installed = Printerlib.TestAndInstallPackage(
        "OpenPrintingPPDs-hpijs",
        "installed"
      )
      _OpenPrintingPPDs_postscript_installed = Printerlib.TestAndInstallPackage(
        "OpenPrintingPPDs-postscript",
        "installed"
      )
      gutenprint_installed = Printerlib.TestAndInstallPackage(
        "gutenprint",
        "installed"
      )
      hplip_installed = Printerlib.TestAndInstallPackage(
        "hplip",
        "installed"
      )
      manufacturer_PPDs_installed = Printerlib.TestAndInstallPackage(
        "manufacturer-PPDs",
        "installed"
      )
      splix_installed = Printerlib.TestAndInstallPackage("splix", "installed") ||
        Printerlib.TestAndInstallPackage("cups-drivers-splix", "installed")
      m2300w_installed = Printerlib.TestAndInstallPackage("m2300w", "installed")
      epson_inkjet_printer_escpr_installed = Printerlib.TestAndInstallPackage(
        "epson-inkjet-printer-escpr",
        "installed"
      )
      Builtins.y2milestone(
        "entering AddDriverDialog with OpenPrintingPPDs_ghostscript_installed:'%1' OpenPrintingPPDs_hpijs_installed:'%2' OpenPrintingPPDs_postscript_installed:'%3' gutenprint_installed:'%4' hplip_installed:'%5' manufacturer_PPDs_installed:'%6' splix_installed:'%7' m2300w_installed:'%8' epson_inkjet_printer_escpr_installed:'%9'",
        _OpenPrintingPPDs_ghostscript_installed,
        _OpenPrintingPPDs_hpijs_installed,
        _OpenPrintingPPDs_postscript_installed,
        gutenprint_installed,
        hplip_installed,
        manufacturer_PPDs_installed,
        splix_installed,
        m2300w_installed,
        epson_inkjet_printer_escpr_installed
      )
      contents = VBox(
        VStretch(),
        Left(
          Label(
            Id("driver_packages_label"),
            # Header for a dialog section where the user can
            # add or remove printer driver packages:
            _("Install or Remove Printer Driver Packages")
          )
        ),
        HBox(
          HSpacing(3),
          VBox(
            Left(
              CheckBox(
                Id("OpenPrintingPPDs-ghostscript"),
                # CheckBox to select or un-select the printer driver package OpenPrintingPPDs-ghostscript.
                # There is no need to have the package name "OpenPrintingPPDs-ghostscript" in this text
                # because it is shown in a separated column to the left of this text.
                "&OpenPrintingPPDs-ghostscript : " +
                  _("Printer Description Files for Ghostscript Drivers"),
                _OpenPrintingPPDs_ghostscript_installed
              )
            ),
            Left(
              CheckBox(
                Id("OpenPrintingPPDs-hpijs"),
                # CheckBox to select or un-select the printer driver package OpenPrintingPPDs-hpijs.
                # There is no need to have the package name "OpenPrintingPPDs-hpijs" in this text
                # because it is shown in a separated column to the left of this text.
                "OpenPrintingPPDs-hp&ijs : " +
                  _("Printer Description Files for some PCL Printers"),
                _OpenPrintingPPDs_hpijs_installed
              )
            ),
            Left(
              CheckBox(
                Id("OpenPrintingPPDs-postscript"),
                # CheckBox to select or un-select the printer driver package OpenPrintingPPDs-postscript.
                # There is no need to have the package name "OpenPrintingPPDs-postscript" in this text
                # because it is shown in a separated column to the left of this text.
                "OpenPrintingPPDs-&postscript : " +
                  _("Printer Description Files for PostScript Printers"),
                _OpenPrintingPPDs_postscript_installed
              )
            ),
            Left(
              CheckBox(
                Id("gutenprint"),
                # CheckBox to select or un-select the printer driver package gutenprint.
                # There is no need to have the package name "gutenprint" in this text
                # because it is shown in a separated column to the left of this text.
                # Do not change or translate "Gutenprint", it is a open source project name.
                # Do not change or translate "Gimp-Print", it is a open source project name.
                "&gutenprint : " +
                  _("Gutenprint/Gimp-Print Driver"),
                gutenprint_installed
              )
            ),
            Left(
              CheckBox(
                Id("hplip"),
                # CheckBox to select or un-select the printer driver packages hplip and hplip-hpijs.
                # There is no need to have the package names "hplip" and "hplip-hpijs" in this text
                # because they are shown in a separated column to the left of this text.
                "&hplip + hplip-hpijs : " +
                  _("Driver for HP Printers and HP All-in-One Devices"),
                hplip_installed
              )
            ),
            Left(
              CheckBox(
                Id("manufacturer-PPDs"),
                # CheckBox to select or un-select the printer driver package manufacturer-PPDs.
                # There is no need to have the package name "manufacturer-PPDs" in this text
                # because it is shown in a separated column to the left of this text.
                "&manufacturer-PPDs : " +
                  _("Manufacturer's PostScript Printer Description Files"),
                manufacturer_PPDs_installed
              )
            ),
            Left(
              CheckBox(
                Id("splix"),
                # CheckBox to select or un-select the printer driver package splix.
                # There is no need to have the package name "splix" in this text
                # because it is shown in a separated column to the left of this text.
                "&splix : " +
                  _("SpliX Driver for SPL Printers without JBIG"),
                splix_installed
              )
            ),
            # Disabled legacy "Driver for Konica Minolta 2300W and 2400W (unmaintained)" so that it is no longer accessible in the dialog:
            #Left(
            #  CheckBox(
            #     Id("m2300w"),
            #    # CheckBox to select or un-select the printer driver package m2300w.
            #    # There is no need to have the package name "m2300w" in this text
            #    # because it is shown in a separated column to the left of this text.
            #    "m2300&w : " +
            #      _("Driver for Konica Minolta 2300W and 2400W (unmaintained)"),
            #    m2300w_installed
            #  )
            #),
            Left(
              CheckBox(
                Id("epson-inkjet-printer-escpr"),
                # CheckBox to select or un-select the printer driver package epson-inkjet-printer-escpr.
                # There is no need to have the package name "epson-inkjet-printer-escpr" in this text
                # because it is shown in a separated column to the left of this text.
                "&epson-inkjet-printer-escpr : " +
                  _("Epson ESC/P-R Inkjet Printer Driver"),
                epson_inkjet_printer_escpr_installed
              )
            )
          )
        ),
        VStretch(),
        Left(
          Label(
            Id("ppd_path_label"),
            # Header for a dialog section where the user can
            # make a printer description file (PPD file) available
            # so that it can be used to set up a print queue with it:
            _("Make a Printer Description File Available")
          )
        ),
        HBox(
          HSpacing(3),
          Left(
            HBox(
              TextEntry(
                Id("ppd_path_input"),
                # TextEntry to specify the full path of a PPD file:
                _(
                  "Printer description &file name with full path where it is located"
                )
              ),
              VBox(
                Label(""),
                PushButton(
                  Id("ppd_file_browser"),
                  # Label of a PushButton to open a file selection box
                  # to browse the file system to select a PPD file:
                  _("&Browse")
                )
              )
            )
          )
        ),
        VStretch()
      )
      # According to the YaST Style Guide (dated Thu, 06 Nov 2008)
      # there is no longer a "abort" functionality which exits the whole module.
      # Instead this button is now named "Cancel" and its functionality is
      # to go back to the Overview dialog (i.e. what the "back" button would do)
      # because it reads "Cancel - Closes the window and returns to the overview."
      # In this case the "overview" is not the actual Overview dialog but the dialog
      # from which this AddDriverDialog was called i.e. BasicAddDialog or BasicModifyDialog.
      # Therefore the button with the "abort" functionality is not shown at all
      # and the button with the "back" functionality is named "Cancel".
      # According to the YaST Style Guide (dated Thu, 06 Nov 2008)
      # the "finish" button in a single (step) configuration dialog must now be named "OK".
      Wizard.SetContentsButtons(
        caption,
        contents,
        Ops.get_string(@HELPS, "add_driver_dialog", ""),
        # Set a new label for the "back" button, see the comment above:
        Label.CancelButton,
        # Set a new label for the "next" button, see the comment above:
        Label.OKButton
      )
      Wizard.HideAbortButton
      ret = nil
      while true
        ret = UI.UserInput
        break if ret == :abort || ret == :cancel || ret == :back
        if ret == "ppd_file_browser"
          ppd_file_name = UI.AskForExistingFile(
            "/tmp",
            "*.ppd *.ppd.gz",
            # Header for a AskForExistingFile popup dialog
            # to browse the file system to select a PPD file:
            _("Select a printer description file")
          )
          if "" != Builtins.filterchars(ppd_file_name, Printer.alnum_chars)
            UI.ChangeWidget(Id("ppd_path_input"), :Value, ppd_file_name)
          end
          next
        end
        if ret == :next
          _OpenPrintingPPDs_ghostscript_install = Convert.to_boolean(
            UI.QueryWidget(Id("OpenPrintingPPDs-ghostscript"), :Value)
          )
          _OpenPrintingPPDs_hpijs_install = Convert.to_boolean(
            UI.QueryWidget(Id("OpenPrintingPPDs-hpijs"), :Value)
          )
          _OpenPrintingPPDs_postscript_install = Convert.to_boolean(
            UI.QueryWidget(Id("OpenPrintingPPDs-postscript"), :Value)
          )
          gutenprint_install = Convert.to_boolean(
            UI.QueryWidget(Id("gutenprint"), :Value)
          )
          hplip_install = Convert.to_boolean(
            UI.QueryWidget(Id("hplip"), :Value)
          )
          manufacturer_PPDs_install = Convert.to_boolean(
            UI.QueryWidget(Id("manufacturer-PPDs"), :Value)
          )
          splix_install = Convert.to_boolean(
            UI.QueryWidget(Id("splix"), :Value)
          )
          m2300w_install = Convert.to_boolean(
            UI.QueryWidget(Id("m2300w"), :Value)
          )
          epson_inkjet_printer_escpr_install = Convert.to_boolean(
            UI.QueryWidget(Id("epson-inkjet-printer-escpr"), :Value)
          )
          ppd_path_input_value = Convert.to_string(
            UI.QueryWidget(Id("ppd_path_input"), :Value)
          )
          # Ignore an effectively empty ppd_path_input_value:
          if _OpenPrintingPPDs_ghostscript_install == _OpenPrintingPPDs_ghostscript_installed &&
              _OpenPrintingPPDs_hpijs_install == _OpenPrintingPPDs_hpijs_installed &&
              _OpenPrintingPPDs_postscript_install == _OpenPrintingPPDs_postscript_installed &&
              gutenprint_install == gutenprint_installed &&
              hplip_install == hplip_installed &&
              manufacturer_PPDs_install == manufacturer_PPDs_installed &&
              splix_install == splix_installed &&
              m2300w_install == m2300w_installed &&
              epson_inkjet_printer_escpr_install == epson_inkjet_printer_escpr_installed &&
              "" ==
                Builtins.filterchars(ppd_path_input_value, Printer.alnum_chars)
            Builtins.y2milestone("Nothing changed in AddDriverDialog.")
            # Exit this dialog:
            break
          end
          Wizard.DisableBackButton
          Wizard.DisableNextButton
          # The following steps might be optimized because currently
          # the package manager is called anew for each individual package
          # so that for each package which is installed SuSEconfig is run.
          # On the other hand this way the user can confirm or reject
          # for each individual package which is to be installed
          # whether or not is should really be installed and
          # for each individual package which is to be removed
          # whether or not is should really be removed.
          # Because of this and because I assume that usually the user
          # does not install or remove several packages at once
          # and because the maximum amount is only 5 packages,
          # I prefer currently to run the package manager
          # well separated for each individual package.
          # Furthermore I do not want to run into whatever complicated issues
          # when I would let the package manager install several packages at once
          # but one package is not avaialble in the repository to be installed.
          # For example on a host without Internet access when whatever rarely used
          # drivers or too-big drivers are not provided on whatever media
          # for whatever product (e.g. a Live CD or a stripped DVD/CD in whatever magazine).
          package_changed = false
          if _OpenPrintingPPDs_ghostscript_install != _OpenPrintingPPDs_ghostscript_installed
            # (more precisely: OpenPrintingPPDs-ghostscript contains most of what cups-drivers contained),
            # see https://bugzilla.novell.com/show_bug.cgi?id=641704
            # To be backward compatible try also cups-drivers:
            if _OpenPrintingPPDs_ghostscript_install
              if Printerlib.TestAndInstallPackage(
                  "OpenPrintingPPDs-ghostscript",
                  "install"
                )
                package_changed = true
              end
              if !Printerlib.TestAndInstallPackage(
                  "OpenPrintingPPDs-ghostscript",
                  "installed"
                )
                if Printerlib.TestAndInstallPackage("cups-drivers", "install")
                  package_changed = true
                end
              end
            else
              if Printerlib.TestAndInstallPackage(
                  "OpenPrintingPPDs-ghostscript",
                  "installed"
                )
                if Printerlib.TestAndInstallPackage(
                    "OpenPrintingPPDs-ghostscript",
                    "remove"
                  )
                  package_changed = true
                end
              end
              if Printerlib.TestAndInstallPackage("cups-drivers", "installed")
                # so that the user can decide not to remove cups-drivers:
                if Printerlib.TestAndInstallPackage("cups-drivers", "remove")
                  package_changed = true
                end
              end
            end
          end
          if _OpenPrintingPPDs_hpijs_install != _OpenPrintingPPDs_hpijs_installed
            if _OpenPrintingPPDs_hpijs_install
              if Printerlib.TestAndInstallPackage(
                  "OpenPrintingPPDs-hpijs",
                  "install"
                )
                package_changed = true
              end
            else
              if Printerlib.TestAndInstallPackage(
                  "OpenPrintingPPDs-hpijs",
                  "remove"
                )
                package_changed = true
              end
            end
          end
          if _OpenPrintingPPDs_postscript_install != _OpenPrintingPPDs_postscript_installed
            if _OpenPrintingPPDs_postscript_install
              if Printerlib.TestAndInstallPackage(
                  "OpenPrintingPPDs-postscript",
                  "install"
                )
                package_changed = true
              end
            else
              if Printerlib.TestAndInstallPackage(
                  "OpenPrintingPPDs-postscript",
                  "remove"
                )
                package_changed = true
              end
            end
          end
          if gutenprint_install != gutenprint_installed
            if gutenprint_install
              if Printerlib.TestAndInstallPackage("gutenprint", "install")
                package_changed = true
              end
            else
              if Printerlib.TestAndInstallPackage("gutenprint", "remove")
                package_changed = true
              end
            end
          end
          if hplip_install != hplip_installed
            if hplip_install
              # because hpijs-standalone conflicts with hplip-hpijs which is required by hplip.
              # It can lead to an almost endless sequence of further problems
              # when hpijs-standalone is removed by the package management system
              # and because we do want to get rid of it, it is removed by plain rpm:
              if Printerlib.TestAndInstallPackage(
                  "hpijs-standalone",
                  "installed"
                )
                Printerlib.TestAndInstallPackage("hpijs-standalone", "remove")
              end
              if !Printerlib.TestAndInstallPackage(
                  "hpijs-standalone",
                  "installed"
                )
                if Printerlib.TestAndInstallPackage("hplip", "install")
                  package_changed = true
                else
                  # or if the installation of hplip has actually failed.
                  # Installation of hplip may have failed because
                  # an old hplip-hpijs may have been still installed
                  # (hplip requires the exact matching hplip-hpijs version).
                  # Therefore here a special error handling if hplip-hpijs is installed.
                  # This special error handling would be also done when hplip-hpijs is installed
                  # and the user has rejected to install hplip but in this very special case
                  # the user just needs to continue to reject all the stuff to get out
                  # without any changes in his installed packages.
                  # Unfortunately even PackageSystem::CheckAndInstallPackagesInteractive(["hplip"])
                  # does neither show a useful error message why an installation failed to the user
                  # (the SATResolver reports the problems and solutions perfectly in y2log)
                  # nor does it let the user do any useful error handling
                  # (it does not let the user choose one of the solutions of the SATResolver)
                  # except a blind and trivial "continue" or "cancel".
                  # It even exits with true if the user decided to "continue" in case of an error
                  # so that the caller cannot distinguish easily if it was a successful installation
                  # or if the installation failed but the user decided to "continue" nevertheless.
                  # Therefore PackageSystem::CheckAndInstallPackagesInteractive(["hplip"])
                  # is totally useless for me here and therefore I implement some
                  # best guess and best effort error handling here on my own.
                  if Printerlib.TestAndInstallPackage(
                      "hplip-hpijs",
                      "installed"
                    )
                    if Printerlib.TestAndInstallPackage("hplip-hpijs", "remove")
                      if Printerlib.TestAndInstallPackage("hplip", "install")
                        package_changed = true
                      else
                        # For whatever reason hpijs-standalone becomes installed on openSUSE 11.0
                        # by whatever magic automatically after hplip-hpijs was removed
                        # but hpijs-standalone conflicts with hplip-hpijs which is required by hplip.
                        if Printerlib.TestAndInstallPackage(
                            "hpijs-standalone",
                            "installed"
                          )
                          # when hpijs-standalone is removed by the package management system
                          # and because we do want to get rid of it, it is removed by plain rpm:
                          Printerlib.TestAndInstallPackage(
                            "hpijs-standalone",
                            "remove"
                          )
                          if !Printerlib.TestAndInstallPackage(
                              "hpijs-standalone",
                              "installed"
                            )
                            if Printerlib.TestAndInstallPackage(
                                "hplip",
                                "install"
                              )
                              package_changed = true
                            end
                          end
                        end
                      end
                    end
                  end
                end
              end
            else
              # Removing HPLIP means to remove the packages hplip, hplip-sane, and hplip-hpijs where
              # hplip must be removed first, then hplip-sane and finally hplip-hpijs because
              # hplip-hpijs is needed by hplip and hplip-sane and hplip-sane is needed by hplip.
              # Since openSUSE 12.1 the HPLIP SANE driver (libsane-hpaio.* files)
              # is split from the hplip package into a separated subpackage hplip-sane,
              # see https://bugzilla.novell.com/show_bug.cgi?id=723870
              # and https://bugzilla.novell.com/show_bug.cgi?id=726316
              if Printerlib.TestAndInstallPackage("hplip", "installed")
                # is actually removed so that the user is free to decide to keep hplip installed:
                if Printerlib.TestAndInstallPackage("hplip", "remove")
                  package_changed = true
                end
              end
              # Only if there is no package hplip installed (regardless if it was removed right now
              # or if it was not installed all the time) it makes sense to remove hplip-sane.
              if !Printerlib.TestAndInstallPackage("hplip", "installed")
                if Printerlib.TestAndInstallPackage("hplip-sane", "installed")
                  # is actually removed so that the user is free to decide to keep hplip-sane installed:
                  if Printerlib.TestAndInstallPackage("hplip-sane", "remove")
                    package_changed = true
                  end
                end
                # Only if there is no package hplip-sane installed (regardless if it was removed right now
                # or if it was not installed all the time) it makes sense to remove hplip-hpijs:
                if !Printerlib.TestAndInstallPackage("hplip-sane", "installed")
                  # so that a test if hplip-hpijs is installed is not needed here.
                  # In TestAndInstallPackage there is a confirmation popup before a package
                  # is actually removed so that the user is free to decide to keep hplip-hpijs installed:
                  if Printerlib.TestAndInstallPackage("hplip-hpijs", "remove")
                    package_changed = true
                  end
                end
              end
            end
          end
          if manufacturer_PPDs_install != manufacturer_PPDs_installed
            if manufacturer_PPDs_install
              if Printerlib.TestAndInstallPackage(
                  "manufacturer-PPDs",
                  "install"
                )
                package_changed = true
              end
            else
              if Printerlib.TestAndInstallPackage("manufacturer-PPDs", "remove")
                package_changed = true
              end
            end
          end
          if splix_install != splix_installed
            # see https://bugzilla.novell.com/show_bug.cgi?id=659579
            # To be backward compatible try also cups-drivers-splix:
            if splix_install
              if Printerlib.TestAndInstallPackage("splix", "install")
                package_changed = true
              end
              if !Printerlib.TestAndInstallPackage("splix", "installed")
                if Printerlib.TestAndInstallPackage(
                    "cups-drivers-splix",
                    "install"
                  )
                  package_changed = true
                end
              end
            else
              if Printerlib.TestAndInstallPackage("splix", "installed")
                if Printerlib.TestAndInstallPackage("splix", "remove")
                  package_changed = true
                end
              end
              if Printerlib.TestAndInstallPackage(
                  "cups-drivers-splix",
                  "installed"
                )
                if Printerlib.TestAndInstallPackage(
                    "cups-drivers-splix",
                    "remove"
                  )
                  package_changed = true
                end
              end
            end
          end
          if m2300w_install != m2300w_installed
            if m2300w_install
              if Printerlib.TestAndInstallPackage("m2300w", "install")
                package_changed = true
              end
            else
              if Printerlib.TestAndInstallPackage("m2300w", "remove")
                package_changed = true
              end
            end
          end
          if epson_inkjet_printer_escpr_install != epson_inkjet_printer_escpr_installed
            if epson_inkjet_printer_escpr_install
              if Printerlib.TestAndInstallPackage(
                  "epson-inkjet-printer-escpr",
                  "install"
                )
                package_changed = true
              end
            else
              if Printerlib.TestAndInstallPackage(
                  "epson-inkjet-printer-escpr",
                  "remove"
                )
                package_changed = true
              end
            end
          end
          # If driver packages were actually changed (the user may have rejected it),
          # enforce that the BasicAddDialog and/or the BasicModifyDialog
          # (only form those dialogs this AddDriverDialog can be called)
          # do re-retrieve the driver information anew from the system.
          # Both the BasicAddDialog and the BasicModifyDialog are re-launched
          # via the sequencer when this AddDriverDialog has finished
          # so that BasicAddDialog and BasicModifyDialog call Printer::DriverItems anew
          # and this calls Printer::CreateDatabase when the ppds list is empty.
          # It would not be more failsafe not to clear the ppds list here
          # because Printer::CreateDatabase overwrites it in any case.
          # If driver packages were actually changed (the user may have rejected it),
          # CUPS backends could have been added or removed (in particular the "hp" backend)
          # so that printer autodetection must also be re-done.
          # Both the BasicAddDialog and the BasicModifyDialog are re-launched
          # via the sequencer when this AddDriverDialog has finished
          # so that BasicAddDialog and BasicModifyDialog call Printer::ConnectionItems anew
          # and this calls Printer::AutodetectPrinters when the connections list is empty.
          # It would not be more failsafe not to clear the connections list here
          # because Printer::AutodetectPrinters overwrites it in any case.
          if package_changed
            Printer.ppds = []
            Printer.connections = []
            # Show the "Restart locally running CUPS daemon" user confirmation popup
            # because usually a change in printer driver RPMs (installation or removal)
            # changes print job processing which requires a restart of cupsd,
            # see https://bugzilla.novell.com/show_bug.cgi?id=888782
            Printerlib.GetAndSetCupsdStatus("restart")
            # There is no "abort" functionality which does a sudden death of the whole module (see dialogs.ycp).
            # Unfortunately when the YaST package installer is run via Printerlib::TestAndInstallPackage
            # it leaves a misused "abort" button labeled "Skip Autorefresh" with WidgetID "`abort"
            # so that this leftover "abort" button must be explicitly hidden here:
            Wizard.HideAbortButton
          end
          # Ignore an effectively empty ppd_path_input_value:
          if "" !=
              Builtins.filterchars(ppd_path_input_value, Printer.alnum_chars)
            if !Printerlib.ExecuteBashCommand(
                Ops.add(Ops.add("ls -l '", ppd_path_input_value), "'")
              )
              Popup.ErrorDetails(
                Builtins.sformat(
                  # where %1 will be replaced by the file name:
                  _("Cannot access '%1'"),
                  ppd_path_input_value
                ), # Popup::ErrorDetails message
                Ops.get_string(Printerlib.result, "stderr", "")
              )
              # Simply exit this dialog because it does not make sense to proceed here
              # and there is nothing else to be done after this:
              break
            end
            if !Printerlib.ExecuteBashCommand(
                Ops.add(
                  Ops.add(
                    "cupstestppd -W constraints -W defaults -W translations -r '",
                    ppd_path_input_value
                  ),
                  "'"
                )
              )
              Popup.ErrorDetails(
                _(
                  "The printer description file is not in compliance with the specification."
                ),
                Ops.add(
                  Ops.get_string(
                    # The cupstestppd report is on stdout:
                    Printerlib.result,
                    "stdout",
                    ""
                  ),
                  "\nREF is the Adobe PostScript Printer Description File Format Specification"
                )
              )
              if !Popup.ContinueCancelHeadline(
                  # when a PPD file is not in compliance:
                  _(
                    "Use the printer description file regardless of its errors?"
                  ),
                  # Body of a Popup::ContinueCancelHeadline
                  # when PPD file is not in compliance:
                  _(
                    "A non-compliant printer description file can lead to arbitrary failures."
                  )
                )
                break
              end
            end
            if !Printerlib.ExecuteBashCommand(
                Ops.add(
                  Ops.add(
                    "test -d /usr/share/cups/model/downloaded || mkdir /usr/share/cups/model/downloaded ; cp '",
                    ppd_path_input_value
                  ),
                  "' /usr/share/cups/model/downloaded"
                )
              )
              Popup.ErrorDetails(
                _("Failed to make the printer description file available"),
                Ops.get_string(Printerlib.result, "stderr", "")
              )
              # Simply exit this dialog because it does not make sense to proceed here
              # and there is nothing else to be done after this:
              break
            end
            # If a ppd was actually installed in /usr/share/cups/model/downloaded
            # enforce that the BasicAddDialog and/or the BasicModifyDialog
            # re-retrieve the driver information anew from the system (see above):
            Printer.ppds = []
          end
          # Exit this dialog in any case:
          break
        end
        Builtins.y2milestone(
          "Ignoring unexpected returncode in AddDriverDialog: %1",
          ret
        )
        next
      end
      Wizard.EnableBackButton
      Wizard.EnableNextButton
      Builtins.y2milestone("leaving AddDriverDialog")
      deep_copy(ret)
    end
  end
end
