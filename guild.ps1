function script:gldGuildMain {
    [reflection.assembly]::LoadWithPartialName("System.Windows.Forms") | Out-Null
    function script:gldMainGui {
        function script:gldQuestSelect {
            function script:gldQuestHeader {
                $script:gldQuestMainHeader = New-Object System.Windows.Forms.Label
                $script:gldQuestMainHeader.Text = "Please Select a Quest:"
                $script:gldQuestMainHeader.Location = New-Object System.Drawing.Point(20, 10)
                $script:gldQuestMainHeader.AutoSize = $true
                $script:gldMainGui.Controls.Add($script:gldQuestMainHeader)

                <#
            $script:gldQuest1Header = New-Object System.Windows.Forms.Label
            $script:gldQuest1Header.Text = "quest 1 easy"
            $script:gldQuest1Header.Location = New-Object System.Drawing.Point(20, 10)
            $script:gldQuest1Header.AutoSize = $true
            $script:gldMainGui.Controls.Add($script:gldQuest1Header)

            $script:gldQuest2Header = New-Object System.Windows.Forms.Label
            $script:gldQuest2Header.Text = "quest 2 medium"
            $script:gldQuest2Header.Location = New-Object System.Drawing.Point(120, 10)
            $script:gldQuest2Header.AutoSize = $true
            $script:gldMainGui.Controls.Add($script:gldQuest2Header)

            $script:gldQuest3Header = New-Object System.Windows.Forms.Label
            $script:gldQuest3Header.Text = "quest 3 hard"
            $script:gldQuest3Header.Location = New-Object System.Drawing.Point(220, 10)
            $script:gldQuest3Header.AutoSize = $true
            $script:gldMainGui.Controls.Add($script:gldQuest3Header)
            #>
            }

            function script:gldQuestButtons {
                $script:gldQuestButton1 = New-Object System.Windows.Forms.Button
                $script:gldQuestButton1.Location = New-Object System.Drawing.Size(20, 30)
                $script:gldQuestButton1.Size = New-Object System.Drawing.Size(70, 23)
                $script:gldQuestButton1.Text = "quest 1"
                $script:gldMainGui.Controls.Add($script:gldQuestButton1)

                $script:gldQuestButton2 = New-Object System.Windows.Forms.Button
                $script:gldQuestButton2.Location = New-Object System.Drawing.Size(120, 30)
                $script:gldQuestButton2.Size = New-Object System.Drawing.Size(70, 23)
                $script:gldQuestButton2.Text = "quest 2"
                $script:gldMainGui.Controls.Add($script:gldQuestButton2)

                $script:gldQuestButton3 = New-Object System.Windows.Forms.Button
                $script:gldQuestButton3.Location = New-Object System.Drawing.Size(220, 30)
                $script:gldQuestButton3.Size = New-Object System.Drawing.Size(70, 23)
                $script:gldQuestButton3.Text = "quest 3"
                $script:gldMainGui.Controls.Add($script:gldQuestButton3)

                $script:gldQuestButton1.Add_Click( {
                        Write-Host "1"
                        $script:gldQuestSelected = 1
                        $script:gldMainGui.Controls.Remove($script:gldQuestSelectedConfirmedlocked)
                        $script:gldMainGui.Controls.Remove($script:gldQuestSelectedConfirmed)
                        #script:gldQuestHoveredLabel
                        script:gldQuestInfo
                        #$script:gldMainGui.Controls.Add($script:gldQuestLabelSelect)
                        #questlabelselect
                    } 
                )
                $script:gldQuestButton2.Add_Click( {
                        Write-Host "2"
                        $script:gldQuestSelected = 2
                        $script:gldMainGui.Controls.Remove($script:gldQuestSelectedConfirmedlocked)
                        $script:gldMainGui.Controls.Remove($script:gldQuestSelectedConfirmed)
                        #script:gldQuestHoveredLabel
                        script:gldQuestInfo
                        #$script:gldMainGui.Controls.Add($script:gldQuestLabelSelect)
                        #questlabelselect
            
                    } 
                )
                $script:gldQuestButton3.Add_Click( {
                        Write-Host "3"
                        $script:gldQuestSelected = 3
                        $script:gldMainGui.Controls.Remove($script:gldQuestSelectedConfirmedlocked)
                        $script:gldMainGui.Controls.Remove($script:gldQuestSelectedConfirmed)
                        #script:gldQuestHoveredLabel
                        script:gldQuestInfo
                        #$script:gldMainGui.Controls.Add($script:gldQuestLabelSelect)
                        #questlabelselect
                    } 
                )
            }
            #show quest headers
            script:gldQuestHeader
            #show quest buttons and make clicky
            script:gldQuestButtons
        }
        #$script:gldMainGui.Controls.Add($script:gldQuestButton1)

        <#
function questlabelselectreset {
    $script:gldMainGui.Controls.Remove($script:gldQuestLabelSelect)
}
#>
        #questlabelselectreset

        function script:gldButtonConfirmSelect {
            $script:gldMainGui.Controls.Remove($script:guildButtonConfirm)
            $script:gldQuestButtonConfirm = New-Object System.Windows.Forms.Button
            $script:gldQuestButtonConfirm.Location = New-Object System.Drawing.Size(100, 120)
            $script:gldQuestButtonConfirm.Size = New-Object System.Drawing.Size(100, 23)
            $script:gldQuestButtonConfirm.Text = "Accept Quest"
            $script:gldMainGui.Controls.Add($script:gldQuestButtonConfirm)
            script:gldQuestButtonConfirmClick
            #gldQuestInfo
        }



        function script:gldQuestSelectedConfirmed {
            $script:gldMainGui.Controls.Remove($script:gldQuestSelectedConfirmed)
            $script:gldQuestSelectedConfirmed = New-Object System.Windows.Forms.Label
            $script:gldQuestSelectedConfirmed.Text = "quest selection confirmed $script:gldQuestSelected" 
            $script:gldQuestSelectedConfirmed.Location = New-Object System.Drawing.Point(85, 150)
            $script:gldQuestSelectedConfirmed.AutoSize = $true
            $script:gldMainGui.Controls.Add($script:gldQuestSelectedConfirmed)   
        }

        function script:gldQuestSelectedConfirmedlocked {
            $script:gldMainGui.Controls.Remove($script:gldQuestSelectedConfirmedlocked)
            $script:gldMainGui.Controls.Remove($script:gldQuestSelectedConfirmed)
            $script:gldQuestSelectedConfirmedlocked = New-Object System.Windows.Forms.Label
            $script:gldQuestSelectedConfirmedlocked.Text = "quest already active: $script:gldCurrentActiveQuest" 
            $script:gldQuestSelectedConfirmedlocked.Location = New-Object System.Drawing.Point(90, 150)
            $script:gldQuestSelectedConfirmedlocked.AutoSize = $true
            $script:gldMainGui.Controls.Add($script:gldQuestSelectedConfirmedlocked)   
        }

        function script:gldQuestHoveredLabel {
            $script:gldMainGui.Controls.Remove($script:gldQuestLabelSelect)
            $script:gldQuestLabelSelect = New-Object System.Windows.Forms.Label
            $script:gldQuestLabelSelect.Text = "you selected quest $script:gldQuestSelected" 
            $script:gldQuestLabelSelect.Location = New-Object System.Drawing.Point(100, 60)
            $script:gldQuestLabelSelect.AutoSize = $true
            $script:gldMainGui.Controls.Add($script:gldQuestLabelSelect)
            #script:gldButtonConfirmSelect
            script:gldQuestInfo   
        }

        function script:gldQuestButtonConfirmClick {
            $script:gldQuestButtonConfirm.Add_Click( {
                    if ($script:gldCurrentActiveQuest -eq 0) {
                        Write-Host "Quest Confirmed"
                        Write-Host "quest: $script:gldQuestSelected"
                        $script:gldCurrentActiveQuest = $script:gldQuestSelected
                        script:gldQuestSelectedConfirmed
                    }
                    else {
                        Write-Host "quest already active"
                        Write-Host "quest: $script:gldCurrentActiveQuest"
                        script:gldQuestSelectedConfirmedlocked
                    }
                    #$script:gldMainGui.Controls.Remove($script:gldQuestLabelSelect)
                    #script:gldQuestHoveredLabel
                    #$script:gldMainGui.Controls.Add($script:gldQuestLabelSelect)
                    #questlabelselect
                } 
            )
        }
   
        function script:gldQuestInfo {
            switch ($script:gldQuestSelected) {
                1 {
                    $script:gldQuestDifficulty = 'EASY'
                    $script:gldQuestReward = "10 gold"
                    $script:gldQuestObjective = "exterminate 10 goblins"
                    script:gldQuestdisplay
                }
                2 {
                    $script:gldQuestDifficulty = 'MEDIUM'
                    $script:gldQuestReward = "20 gold"
                    $script:gldQuestObjective = "exterminate 20 goblins"
                    script:gldQuestdisplay
                }
                3 {
                    $script:gldQuestDifficulty = 'HARD'
                    $script:gldQuestReward = "30 gold"
                    $script:gldQuestObjective = "exterminate 30 goblins"
                    script:gldQuestdisplay
                }
            }   
        }

        function script:gldQuestdisplay {
            $script:gldMainGui.Controls.Remove($script:gldQuestdisplay)
            $script:gldQuestdisplay = New-Object System.Windows.Forms.Label
            $script:gldQuestdisplay.Text = "Difficulty: $script:gldQuestDifficulty `nQuest reward: $script:gldQuestReward `nQuest objective: $script:gldQuestObjective"
            $script:gldQuestdisplay.Location = New-Object System.Drawing.Point(85, 70)
            $script:gldQuestdisplay.AutoSize = $true
            $script:gldMainGui.Controls.Add($script:gldQuestdisplay)
            script:gldButtonConfirmSelect
        }
        function script:gldMainGuiInit {
            $script:gldMainGui = New-Object System.Windows.Forms.Form
            $script:gldMainGui.Size = New-Object System.Drawing.Point(500, 500)
            $script:gldMainGui.TopMost = $true
            #no quest active
            $script:gldCurrentActiveQuest = 0
            #show quest labels and buttons
            script:gldQuestSelect
        }
        #init starting state
        script:gldMainGuiInit
    }

    #declare all functions
    script:gldMainGui
    #show gldMainGui window
    $script:gldMainGui.ShowDialog()
}

#script:gldGuildMain
#gldGuildMain